import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// The auto-advance transition race (case study CS-2, oss_player#97; user
/// report 2026-10-23): when an episode ends, the playlist echo (`updateQueue`
/// via `removeFromQueue`'s re-emission) and `playEpisode` both start a load
/// of the same next episode milliseconds apart. The incident's server-side
/// double media fetch and the lost play intent are both gone with the
/// download pipeline — the streaming-only contract is: racing callers join
/// ONE in-flight load, exactly ONE audio-source load happens for the
/// episode's remote URL, and the play intent survives.
///
/// AudioService.init is once-per-process; this test gets its own file
/// (=> isolate) so the boot does not trip that assert.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(mockAudioSessionChannel);

  test(
    'auto-advance: two racing loads of the same next episode perform one '
    "audio-source load, never a download, and preserve auto-play (was: the "
    "queue echo's non-auto-play load won and the next episode sat "
    'loaded-but-paused)',
    () async {
      final episodeA = fakePlaylistEpisode('238-261007');
      final episodeB = fakePlaylistEpisode('239-261014');
      final harness = AudioPlayerPodHarness(episodes: [episodeA, episodeB]);
      await harness.boot();

      // The user plays the latest episode; it starts streaming.
      final playFuture = harness.pod().playEpisode(episodeA);
      await playFuture;
      expect(await harness.isPlaying(), isTrue);
      expect(harness.loaderFor(episodeA).tryDownloadCalls, 0,
          reason: 'streaming contract: even the play path must not consult '
              'the download pipeline');

      // The episode ends. removeFromQueue parks on its gate — the DELETE /
      // re-POST churn between the queue mutation and playing the next item
      // took 45–400 ms on the server in the incident.
      harness.playlist.removeFromQueueGate = Completer<void>();
      harness.platformPlayer.fakePosition =
          episodeA.duration ?? const Duration(minutes: 46);
      harness.platformPlayer.emitEvent(
        state: ProcessingStateMessage.completed,
      );
      await pumpEventQueue(times: 10);

      // The playlist re-emission already reached updateQueue: it asked for
      // the next episode while playEpisode is still waiting for the churn
      // (the race window, exactly as on the server — load completed without
      // any download event because the load is direct now).
      // The churn resolves; playEpisode resumes and asks for the SAME
      // episode again — with autoPlay, so this join carries the play intent
      // and must start playback.
      harness.playlist.removeFromQueueGate?.complete();
      await pumpEventQueue(times: 10);

      // Incident signatures, streaming era:
      // (1) the download pipeline was NEVER consulted (was: one or more
      //     full-episode downloads per load — the download-event timing
      //     decided who won);
      // (2) exactly one audio-source load for the next episode (was: the
      //     incident's two same-millisecond media fetches);
      // (3) auto-play actually happens (the report: "does not play … just
      //     stuck there").
      expect(harness.loaderFor(episodeB).tryDownloadCalls, 0,
          reason: 'streaming contract: the transition races direct loads, '
              'no download stream in between');
      expect(
        harness.platformPlayer.loadedUris
            .where((uri) => uri == episodeB.url)
            .length,
        1,
        reason: 'racing callers join one in-flight load; one source-set',
      );
      expect(await harness.isPlaying(), isTrue);
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );

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
      // Exactly one source-set (the #97 guarantee, carried from "one
      // download for concurrent subscribers" into the streaming world).
      expect(harness.platformPlayer.loadedUris.length, 1);
      expect(harness.platformPlayer.lastLoadedUri, episodeB.url);
      // And the download pipeline never entered the picture.
      expect(harness.loaderFor(episodeB).tryDownloadCalls, 0,
          reason: 'streaming contract: loads go straight to the player');
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
