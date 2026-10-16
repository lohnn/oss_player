import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/services/podcast_audio_handler.dart';

import '../helpers/fake_just_audio_platform.dart';
import '../test_data_models/test_episode.dart';
import '../test_data_models/test_user_episode_status.dart';

/// The auto-advance pause bug (case study CS-1): while a (now-)downloaded
/// episode streamed, every download progress tick re-ran
/// `loadEpisode(autoPlay: true)`, whose same-URI guard called `play()` —
/// undoing every pause press within milliseconds — and the download's final
/// transition re-applied a stale persisted position, audibly rewinding
/// playback. A single transition also generated thousands of unnecessary
/// persisted-status reads along the way.
class _StubRepository implements Repository {
  int updateEpisodePositionCalls = 0;

  @override
  Future<void> updateEpisodePosition(Episode episode, Duration position) async {
    updateEpisodePositionCalls++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'Repository.${invocation.memberName} was not expected in this test',
    );
  }
}

class _AudioHarness {
  final FakeJustAudioPlatform fake = FakeJustAudioPlatform();
  final _StubRepository repository = _StubRepository();
  late final PodcastAudioHandler handler;

  final Episode episode = TestEpisode(
    id: EpisodeId('236-260904'),
    url: Uri.parse('https://media.example.com/236_260904.mp3'),
    title: 'Test episode 236',
    imageUrl: Uri.parse('https://example.com/art.jpg'),
    podcastId: PodcastId('test-podcast'),
    duration: const Duration(minutes: 47),
  );

  /// Loads the episode's remote stream, like auto-advance does.
  Future<void> loadRemote({bool autoPlay = true, Duration position = Duration.zero}) {
    return handler.loadEpisode(
      episode,
      episodeUri: episode.url,
      status: EpisodeWithStatus(
        episode: episode,
        status: TestUserEpisodeStatus(
          episodeId: episode.id,
          currentPosition: position,
        ),
      ),
      autoPlay: autoPlay,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // The handler takes a real AudioSession; without a plugin registry its
    // setActive() would throw MissingPluginException in tests.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('com.ryanheise.audio_session'),
          (call) async => null,
        );
  });

  Future<PodcastAudioHandler> buildHandler(_AudioHarness harness) async {
    final handler = PodcastAudioHandler(
      audioSession: await AudioSession.instance,
      repository: harness.repository,
    );
    return harness.handler = handler;
  }

  test(
    'loadEpisode: an explicit pause survives repeated same-URI auto-play '
    'loads (was: undone by the download progress ticks within ~3 ms)',
    () async {
      // This is the auto-advance path: every download progress tick used to
      // hit loadEpisode with the same URI and autoPlay=true.
      final harness = _AudioHarness();
      JustAudioPlatform.instance = harness.fake;
      final handler = await buildHandler(harness);

      await handler.loadEpisode(harness.episode,
        episodeUri: harness.episode.url,
        status: EpisodeWithStatus(
          episode: harness.episode,
          status: TestUserEpisodeStatus(
            episodeId: harness.episode.id,
            currentPosition: Duration.zero,
          ),
        ),
        autoPlay: true,
      );
      expect(handler.isPlaying, isTrue);

      // The user presses pause (notification or app UI).
      await handler.pause();
      expect(handler.isPlaying, isFalse);

      // The next download progress tick arrives — same URI, autoPlay true.
      await handler.loadEpisode(harness.episode,
        episodeUri: harness.episode.url,
        status: EpisodeWithStatus(
          episode: harness.episode,
          status: TestUserEpisodeStatus(
            episodeId: harness.episode.id,
            currentPosition: const Duration(seconds: 21),
          ),
        ),
        autoPlay: true,
      );

      // Incident signature: the pause had been undone ~3 ms later.
      expect(handler.isPlaying, isFalse,
          reason:
              'A same-URI loadEpisode must not re-assert play and thereby '
              'override an explicit pause');
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );

  test(
    'loadEpisode: a same-URI load never reloads the underlying source',
    () async {
      final harness = _AudioHarness();
      JustAudioPlatform.instance = harness.fake;
      await buildHandler(harness);

      await harness.loadRemote();
      final loadsAfterFirst = harness.fake.player.loadCount;
      expect(loadsAfterFirst, 1);

      await harness.loadRemote();
      expect(harness.fake.player.loadCount, loadsAfterFirst,
          reason: 'Same source must be recognized as already loaded');
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );

  test(
    'loadEpisode: switching sources mid-episode applies the live position, '
    'not the stale persisted snapshot (was: rewound by the persisted '
    'snapshot lag)',
    () async {
      final harness = _AudioHarness();
      JustAudioPlatform.instance = harness.fake;
      final handler = await buildHandler(harness);

      await harness.loadRemote(autoPlay: false);

      // The episode keeps playing from the stream; the platform reports the
      // live position at 28 s (the download just finished).
      harness.fake.player.fakePosition = const Duration(seconds: 28);
      harness.fake.player.emitEvent();
      await pumpEventQueue();
      expect(harness.fake.player.lastLoadedUri, harness.episode.url);

      // Takeover: the final download event swaps the player to the local file,
      // carrying the *persisted* status (throttled save; still says 21 s).
      await handler.loadEpisode(
        harness.episode,
        episodeUri: Uri.parse('file:///cache/episodes/236_260904.mp3'),
        status: EpisodeWithStatus(
          episode: harness.episode,
          status: TestUserEpisodeStatus(
            episodeId: harness.episode.id,
            currentPosition: const Duration(seconds: 21),
          ),
        ),
      );

      final initialPosition =
          harness.fake.player.loadedInitialPositions.last;
      final seek = harness.fake.player.seekPositions.isEmpty
          ? null
          : harness.fake.player.seekPositions.last;
      final applied = initialPosition ?? seek;

      // Incident signature: listeners heard the episode jump back by the
      // throttled-save lag (up to 10 s; here exactly 7 s).
      expect(
        applied,
        const Duration(seconds: 28),
        reason:
            'Cache takeover for the SAME episode must prefer the live position '
            'over the stale persisted snapshot',
      );
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
