import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// Pin: a fresh episode has no status row (the incident's status GETs
/// returned a literal `[]`), which the closed app resolves to position 0;
/// the load must simply start from the beginning and auto-play.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(mockAudioSessionChannel);

  test(
    'auto-advance: an episode without a persisted status loads and '
    'auto-plays from the start',
    () async {
      final episodeB = fakePlaylistEpisode('239-261014');
      final harness = AudioPlayerPodHarness(episodes: [episodeB]);
      await harness.boot();

      final loadFuture = harness.pod().loadNextEpisode(
            episodeB,
            autoPlay: true,
          );
      await pumpEventQueue(times: 10);
      await emitRemoteOnEveryHandedOutStream(
        harness.loaderFor(episodeB),
        episodeB.url,
      );
      await loadFuture;

      expect(await harness.isPlaying(), isTrue);
      expect(harness.platformPlayer.loadedUris.last, episodeB.url);
      expect(harness.repository.episodeStatusReads, greaterThan(0));
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
