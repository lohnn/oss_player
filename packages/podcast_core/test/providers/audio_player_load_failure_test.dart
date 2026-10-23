import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// The silent-load-failure family behind the same user's 2026-10-21 report
/// ("När jag tryckte på play hände det inget", zero media requests in that
/// session) and today's stuck bar: failures inside the next-episode load
/// path were swallowed, leaving the player on the finished episode (its
/// completed state reads as the progress bar stuck at the end) with nothing
/// surfaced anywhere.
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

      // The next episode's load is asked for and still pending when the
      // download stream fails — the incident's shape. The expectation is
      // attached before the failure is delivered so the opportunity to
      // observe it is not a race.
      final loadFuture = harness.pod().loadNextEpisode(
            episodeB,
            autoPlay: true,
          );
      final failure = expectLater(loadFuture, throwsA(isA<Exception>()));
      await pumpEventQueue(times: 10);

      // The download stream fails, like the incident's broken load did.
      await emitErrorOnEveryHandedOutStream(
        harness.loaderFor(episodeB),
        Exception('download failed'),
      );
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
