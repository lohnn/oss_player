import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// The silent-load-failure family behind the same user's 2026-10-21 report
/// and the stuck bar of 2026-10-23: failures inside the next-episode load
/// path were swallowed, leaving the player on the finished episode (its
/// completed state reads as the progress bar stuck at the end) with nothing
/// surfaced anywhere. Streaming era: load errors arrive from the platform
/// (source fetch/decode), so the failure is injected on the recording fake
/// platform instead of a download stream; the guarantee is unchanged — the
/// caller's future throws AND the failure reaches the telemetry sink with
/// the episode in context (the cemented RED signature in TDD.md).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(mockAudioSessionChannel);

  test(
    'auto-advance: a failed next-episode load is reported, not swallowed '
    '(was: silent stay on the finished episode — bar stuck at the end, '
    'nothing logged)',
    () async {
      final episodeA = fakePlaylistEpisode('238-261007');
      final episodeB = fakePlaylistEpisode('291-261020');
      final harness = AudioPlayerPodHarness(episodes: [episodeA, episodeB]);
      await harness.boot();

      // The next episode's load is asked for while still pending when the
      // platform-level load fails. The expectation is attached before the
      // failure is delivered so the opportunity to observe it is not a race.
      final loadFuture = harness.pod().loadNextEpisode(
            episodeB,
            autoPlay: true,
          );
      final failure = expectLater(loadFuture, throwsA(isA<StateError>()));
      harness.platformPlayer.throwOnLoad = true;
      await pumpEventQueue(times: 10);
      await failure;

      // The failure must reach the telemetry sink with the episode in
      // context.
      expect(harness.logSink.errorEvents, isNotEmpty);
      final report = harness.logSink.errorEvents.last;
      expect(report.context['episode_id'], episodeB.id.id);
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
