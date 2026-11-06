import 'dart:io';

import 'package:audio_service_platform_interface/audio_service_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/user_episode_status.model.dart';
import 'package:podcast_core/providers/audio_player_provider.dart';
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
/// - [repository]: canned episode statuses (a fresh episode = no row).
/// - [logSink]: records every reported telemetry event.
///
/// The auto-advance pause bug (CS-1) named the fake platform; the CS-2 race
/// adds the queue seam: during the end-of-episode transition,
/// `removeFromQueue`'s re-emission and `playEpisode` both ask for the same
/// next-episode load milliseconds apart, and which of them wins decides
/// whether the user gets music or a progress bar stuck at the end. The
/// download seam those tests used to steer (`FakeEpisodeLoader`) is gone
/// with the download pipeline itself: loads are direct now, and the
/// "download pipeline was consulted" pins of the removal were checked in
/// the RED commit and retired with the pipeline they measured.
class AudioPlayerPodHarness {
  final FakeJustAudioPlatform fakeAudio = FakeJustAudioPlatform();
  final FakePlaylistPod playlist;
  final FakeAudioRepository repository = FakeAudioRepository();
  final RecordingLogSink logSink = RecordingLogSink();

  /// Every episode this test can touch (the podcast pod receives these via
  /// the playlist; family overrides match by the same object identity).
  final List<Episode> episodes;

  AudioPlayerPodHarness({this.episodes = const []})
    : playlist = FakePlaylistPod(episodes);

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
      ],
    );
    addTearDown(container.dispose);

    // Start the build. Its returned `future` only settles after the first
    // state assignment, which — like in the app — happens once the playlist
    // listener's initial `updateQueue` load completes; the load is direct
    // now, so the boot needs no test-side event timing at all.
    container.read(audioPlayerPodProvider);
    await container.read(audioPlayerPodProvider.future);
    await pumpEventQueue(times: 10);
  }
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
