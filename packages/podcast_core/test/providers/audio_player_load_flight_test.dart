import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// The #97 single-flight guarantee, carried into the streaming world: two
/// `loadNextEpisode` calls for the same next episode — the end-of-episode
/// queue echo and the user's play intent — must produce exactly ONE
/// audio-source load, and the strongest play intent among the racing
/// callers must win (this replaces the deleted download-era guarantee
/// "one download for concurrent subscribers": there is no download to
/// dedupe anymore, but there is still exactly one load to not duplicate).
///
/// Own file (=> own isolate): boots the pod through AudioService.init,
/// which asserts once-per-process.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(mockAudioSessionChannel);

  test(
    'two loadNextEpisode calls while one load is in flight produce exactly '
    'one audio-source load (was: the second call cancelled and restarted '
    'the first one)',
    () async {
      final episodeB = fakePlaylistEpisode('239-261014');
      final harness = AudioPlayerPodHarness(episodes: [episodeB]);
      await harness.boot();

      // Two racing calls, launched back-to-back before either resolves —
      // the structure of the transition race without the playlist dance.
      final first = harness.pod().loadNextEpisode(episodeB);
      final second = harness.pod().loadNextEpisode(episodeB, autoPlay: true);
      await Future.wait([first, second]);

      // The strongest play intent among the racing callers wins: the second
      // call asked for playback, so the joined flight must end playing.
      expect(await harness.isPlaying(), isTrue);
      // Exactly one source-set across the racing callers.
      expect(harness.platformPlayer.loadedUris.length, 1);
      expect(harness.platformPlayer.lastLoadedUri, episodeB.url);
      // The download pipeline is structurally gone (the "no download
      // consulted" side of this pin was the RED run of the removal).
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
