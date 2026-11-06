import 'dart:async';
import 'dart:io';

import 'package:audio_service_platform_interface/audio_service_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/user_episode_status.model.dart';
import 'package:podcast_core/providers/audio_player_provider.dart';
import 'package:podcast_core/providers/episode_loader_provider.dart';
import 'package:podcast_core/providers/playlist_pod_provider.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/services/logging/log_sink.dart';
import 'package:podcast_core/services/logging/log_sink_provider.dart';

import '../test_data_models/test_user_episode_status.dart';
import 'fake_just_audio_platform.dart';
import 'fake_playlist_pod.dart';

/// Full environment for driving `AudioPlayerPod` — the auto-advance
/// transition code — against the real `PodcastAudioHandler` over the CS-1
/// [FakeJustAudioPlatform], with every backend-facing side faked:
///
/// - [playlist]: a controllable play-queue stream (the CS-2 seam) that drives
///   `updateQueue` exactly like the app's realtime echo does.
/// - [loader]: the download seam. Its `tryDownloadCalls` count is the
///   streaming contract's red line: the streaming-only load must never
///   consult the download pipeline, so any consult fails the test. The
///   streams self-emit one remote event, which makes the CURRENT download
///   driven path complete like a streaming load would (same source-set,
///   no test-side timing), while the count still exposes the difference.
/// - [repository]: canned episode statuses (a fresh episode = no row).
/// - [logSink]: records every reported telemetry event.
///
/// The auto-advance pause bug (CS-1) named the fake platform; the CS-2 race
/// adds the queue seam: during the end-of-episode transition,
/// `removeFromQueue`'s re-emission and `playEpisode` both ask for the same
/// next-episode load milliseconds apart, and which of them wins decides
/// whether the user gets music or a progress bar stuck at the end.
class AudioPlayerPodHarness {
  final FakeJustAudioPlatform fakeAudio = FakeJustAudioPlatform();
  final FakePlaylistPod playlist;
  final FakeEpisodeLoader loader = FakeEpisodeLoader();
  final FakeAudioRepository repository = FakeAudioRepository();
  final RecordingLogSink logSink = RecordingLogSink();

  /// Every episode this test can touch; each gets its own [FakeEpisodeLoader]
  /// override (the family's argument is matched by the same object identity
  /// the pod received from the playlist).
  final List<Episode> episodes;
  final _loaders = <Episode, FakeEpisodeLoader>{};

  AudioPlayerPodHarness({this.episodes = const []})
    : playlist = FakePlaylistPod(episodes);

  /// The download seam for one episode; test-driveable via `call(i)`.
  FakeEpisodeLoader loaderFor(Episode episode) =>
      _loaders.putIfAbsent(episode, FakeEpisodeLoader.new);

  FakePlatformAudioPlayer get platformPlayer => fakeAudio.player;

  /// The playing flag as the real `just_audio` player reports it, surfaced
  /// through audio_service's playback state (what the app's UI listens to).
  Future<bool> isPlaying() async {
    await pumpEventQueue(times: 5);
    final sub = container.listen(audioStateProvider, (_, _) {});
    final state = await container.read(audioStateProvider.future);
    sub.close();
    await pumpEventQueue(times: 2);
    return state.playing;
  }

  AudioPlayerPod pod() => container.read(audioPlayerPodProvider.notifier);

  late final ProviderContainer container;

  /// Bootstraps the pod (registers the playlist listener, builds the handler
  /// through `AudioService.init`). Call inside a `test()` body: it wires
  /// `addTearDown` for the container.
  Future<void> boot() async {
    JustAudioPlatform.instance = fakeAudio;
    AudioServicePlatform.instance = FakeAudioServicePlatform();

    container = ProviderContainer(
      overrides: [
        repositoryProvider.overrideWith((ref) => repository),
        playlistPodProvider.overrideWith(() => playlist),
        logSinkProvider.overrideWithValue(logSink),
        for (final episode in episodes)
          episodeLoaderProvider(episode).overrideWith(
            () => loaderFor(
              episodes.firstWhere((candidate) => candidate == episode),
            ),
          ),
      ],
    );
    addTearDown(container.dispose);

    // Start the build. Its returned `future` only settles after the first
    // state assignment, which — like in the app — happens once the playlist
    // listener's initial `updateQueue` load completes. The auto-emit fake
    // loader hands out an immediately-emitting stream, so the load completes
    // on subscription without test-side event timing.
    container.read(audioPlayerPodProvider);
    await container.read(audioPlayerPodProvider.future);
    await pumpEventQueue(times: 10);
  }
}

/// Controllable replacement for the download provider. Every `tryDownload()`
/// call hands out a stream that immediately reports the episode's remote URI
/// and closes: the CURRENT (download-driven) path needs one event to load
/// and complete, and this makes it observably equivalent to a streaming
/// load — same single remote source-set, no timing dependence in tests —
/// while `tryDownloadCalls` keeps recording that the download pipeline was
/// consulted at all, which is exactly the thing the streaming-only
/// contract ("load the episode's remote URL directly, never consult a
/// download stream") counts.
class FakeEpisodeLoader extends EpisodeLoader {
  int tryDownloadCalls = 0;
  final _downloads = <_FakeEpisodeDownload>[];

  /// Streams handed out, in call order.
  _FakeEpisodeDownload call(int index) => _downloads[index];

  @override
  Future<EpisodeFileResponse> build(Episode episode) async {
    ref.keepAlive();
    return RemoteEpisodeFile(remoteUri: episode.url);
  }

  @override
  Stream<EpisodeFileResponse> tryDownload() {
    tryDownloadCalls++;
    // Emit the remote-URI event and STAY OPEN: closing here would make the
    // stream's done event race the in-flight player load (onDone would
    // complete the flight before the load applied — the exact
    // silent-failure shape the loader must never manufacture). The current
    // download path keeps its stream open across the download; so does this
    // fake.
    final download = _FakeEpisodeDownload(episode)
      ..controller.add(RemoteEpisodeFile(remoteUri: episode.url));
    _downloads.add(download);
    return download.stream;
  }
}

/// One handed-out download stream, test-driveable. A single-subscription
/// controller: the self-emitted event buffers until whoever subscribes
/// (the current code always has exactly one subscriber — the flight join
/// means racing callers never hand out a second stream).
class _FakeEpisodeDownload {
  final Episode episode;
  final controller = StreamController<EpisodeFileResponse>();

  _FakeEpisodeDownload(this.episode);

  Stream<EpisodeFileResponse> get stream => controller.stream;

  /// Emits the first "remote URI" event, like the download manager reporting
  /// the source the player should start from.
  void emitRemote(Uri remoteUri) =>
      controller.add(RemoteEpisodeFile(remoteUri: remoteUri));

  void emitError(Object error) =>
      controller.addError(error, StackTrace.current);
}

/// Records status reads so tests can count them like the incident's server
/// logs did. A fresh episode (no row) resolves to `currentPosition: 0`,
/// mirroring the closed app's `getUserEpisodeStatus` fallback.
class FakeAudioRepository implements Repository {
  int episodeStatusReads = 0;
  final markedListened = <String>[];
  final positionUpdates = <(String, Duration)>[];

  @override
  Future<UserEpisodeStatus> getUserEpisodeStatus(Episode episode) async {
    episodeStatusReads++;
    return TestUserEpisodeStatus(
      episodeId: episode.id,
      currentPosition: Duration.zero,
    );
  }

  @override
  Future<void> markEpisodeListened(
    EpisodeId episodeId, {
    bool isPlayed = true,
  }) async {
    markedListened.add(episodeId.id);
  }

  @override
  Future<void> updateEpisodePosition(Episode episode, Duration position) async {
    positionUpdates.add((episode.id.id, position));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'Repository.${invocation.memberName} was not expected in this test',
    );
  }
}

class RecordingLogSink extends LogSink {
  final events = <LogEvent>[];

  List<LogEvent> get errorEvents =>
      events.where((event) => event.level == LogLevel.error).toList();

  @override
  void log(LogEvent event) {
    events.add(event);
  }
}

/// audio_service needs a platform to talk to during `AudioService.init`; the
/// handler's queue/media-item plumbing all lands here. A recording shell
/// around the same no-op behaviour the real platform provides.
class FakeAudioServicePlatform extends AudioServicePlatform {
  final setQueueRequests = <SetQueueRequest>[];
  final setMediaItemRequests = <SetMediaItemRequest>[];
  final setStates = <SetStateRequest>[];

  @override
  Future<void> configure(ConfigureRequest request) async {}

  @override
  Future<void> setAndroidPlaybackInfo(
    SetAndroidPlaybackInfoRequest request,
  ) async {}

  @override
  Future<void> androidForceEnableMediaButtons(
    AndroidForceEnableMediaButtonsRequest request,
  ) async {}

  @override
  Future<void> notifyChildrenChanged(
    NotifyChildrenChangedRequest request,
  ) async {}

  @override
  void setHandlerCallbacks(AudioHandlerCallbacks callbacks) {}

  @override
  Future<void> setMediaItem(SetMediaItemRequest request) async {
    setMediaItemRequests.add(request);
  }

  @override
  Future<void> setQueue(SetQueueRequest request) async {
    setQueueRequests.add(request);
  }

  @override
  Future<void> setState(SetStateRequest request) async {
    setStates.add(request);
  }

  @override
  Future<void> stopService(StopServiceRequest request) async {}
}

/// Mocks the platform channels `AudioSession.instance` (audio_session) and
/// audio_service's `DefaultCacheManager` construction need. The same
/// arrangement as the CS-1 harness, plus the path_provider channel that only
/// enters through `AudioService.init`.
void mockAudioSessionChannel() {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  messenger.setMockMethodCallHandler(
    const MethodChannel('com.ryanheise.audio_session'),
    (call) async => null,
  );
  final tempPath = Directory.systemTemp
      .createTempSync('podcase-audio-harness')
      .path;
  addTearDown(() {
    Directory(tempPath).deleteSync(recursive: true);
  });
  messenger.setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/path_provider'),
    (call) async => tempPath,
  );
}

/// Delivers the "remote URI" event on every stream the loader has handed
/// out for an episode so a test does not need to know which racing caller's
/// subscription is the live one; cancelled subscriptions are inert.
Future<void> emitRemoteOnEveryHandedOutStream(
  FakeEpisodeLoader loader,
  Uri remoteUri,
) async {
  for (var i = 0; i < loader.tryDownloadCalls; i++) {
    loader.call(i).emitRemote(remoteUri);
  }
  await pumpEventQueue(times: 5);
}

/// Same, for a stream failure (the swallowed-load-failure family).
Future<void> emitErrorOnEveryHandedOutStream(
  FakeEpisodeLoader loader,
  Object error,
) async {
  for (var i = 0; i < loader.tryDownloadCalls; i++) {
    loader.call(i).emitError(error);
  }
  await pumpEventQueue(times: 5);
}
