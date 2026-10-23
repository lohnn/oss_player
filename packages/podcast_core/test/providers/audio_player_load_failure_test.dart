import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// The silent-load-failure family behind the same user's 2026-10-21 report
/// ("När jag tryckte på play hände det inget", zero media requests in that
/// session) and today's stuck bar: failures inside the next-episode load
/// path were swallowed, leaving the player on the finished episode with
/// nothing surfaced anywhere.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(mockAudioSessionChannel);

  test(
    'auto-advance: a failed next-episode load is reported, not swallowed '
    '(was: silent stay on the finished episode — bar stuck at the end, '
    'nothing logged)',
    () async {
      final episodeB = fakePlaylistEpisode('291-261020');
      final harness = AudioPlayerPodHarness(episodes: [episodeB]);
      await harness.boot();

      final loadFuture = harness.pod().loadNextEpisode(episodeB);
      await pumpEventQueue(times: 10);

      // The download stream fails, like the incident's broken load did.
      await emitErrorOnEveryHandedOutStream(
        harness.loaderFor(episodeB),
        Exception('download failed'),
      );

      // The failure must reach the telemetry sink with the episode in
      // context, and the load must resolve as failed for its callers.
      await expectLater(loadFuture, throwsA(isA<Exception>()));
      expect(harness.logSink.errorEvents, isNotEmpty);
      final report = harness.logSink.errorEvents.last;
      expect(report.context['episode_id'], episodeB.id.id);
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
