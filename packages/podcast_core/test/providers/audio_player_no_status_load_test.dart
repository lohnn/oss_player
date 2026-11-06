import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// Pin: a fresh episode has no status row (the incident's status GETs
/// returned a literal `[]`), which the app resolves to position 0; the load
/// must simply start from the beginning and auto-play. Streaming era: the
/// load reads the persisted status and drives the player directly — no
/// download pipeline involved.
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
      await loadFuture;

      expect(await harness.isPlaying(), isTrue);
      expect(harness.platformPlayer.lastLoadedUri, episodeB.url);
      expect(harness.repository.episodeStatusReads, greaterThan(0));
      // The streaming contract: the load went straight to the player; there
      // is no download pipeline left to consult (that half of the pin was
      // the RED run of the removal and retired with the pipeline).
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
