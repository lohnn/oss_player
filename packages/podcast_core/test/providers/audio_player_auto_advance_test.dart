import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';

import '../helpers/fake_audio_player_harness.dart';
import '../helpers/fake_playlist_pod.dart';

/// The auto-advance transition race (case study CS-2, oss_player#97; user
/// report 2026-10-23, session fac40073, app 0.1.27/189): when an episode
/// ends, the playlist echo (`updateQueue` via `removeFromQueue`'s
/// re-emission) and `playEpisode` both start a load of the same next episode
/// milliseconds apart. The server saw two same-millisecond media GETs and no
/// position writes afterwards: the user got "the new one shows as if it's at
/// the end in the progress bar, and does not play. it's just 'stuck' there."
///
/// AudioService.init is once-per-process; this test gets its own file
/// (=> isolate) so the boot does not trip that assert.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(mockAudioSessionChannel);

  test(
    'auto-advance: two racing loads of the same next episode perform one '
    "download and preserve auto-play (was: the queue echo's non-auto-play "
    'load won and the next episode sat loaded-but-paused)',
    () async {
      final episodeA = fakePlaylistEpisode('238-261007');
      final episodeB = fakePlaylistEpisode('239-261014');
      final harness = AudioPlayerPodHarness(episodes: [episodeA, episodeB]);
      await harness.boot();
      final loaderB = harness.loaderFor(episodeB);

      // The user plays the latest episode; it starts streaming. (Its load
      // was already asked for once by the initial playlist echo during boot;
      // playEpisode's racing auto-play request joins it after the fix,
      // which is why it may not add another download.)
      final playFuture = harness.pod().playEpisode(episodeA);
      await pumpEventQueue(times: 10);
      await emitRemoteOnEveryHandedOutStream(
        harness.loaderFor(episodeA),
        episodeA.url,
      );
      await playFuture;
      expect(await harness.isPlaying(), isTrue);

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
      // the next episode's download while playEpisode is still waiting for
      // the churn (this is the race window, exactly as on the server).
      expect(loaderB.tryDownloadCalls, 1);

      // The download reports its remote source during that window.
      await emitRemoteOnEveryHandedOutStream(loaderB, episodeB.url);

      // The churn resolves; playEpisode resumes and asks for the SAME
      // episode again — with autoPlay even.
      harness.playlist.removeFromQueueGate?.complete();
      await pumpEventQueue(times: 10);

      // Incident signatures:
      // (1) one download, not one per racing caller (the server saw the
      //     episode's media fetched twice within the same millisecond);
      // (2) auto-play actually happens (the report: "does not play … just
      //     stuck there").
      expect(await harness.isPlaying(), isTrue);
      expect(loaderB.tryDownloadCalls, 1);
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
