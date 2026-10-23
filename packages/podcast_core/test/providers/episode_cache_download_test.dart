import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_core/providers/episode_loader_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../helpers/fake_playlist_pod.dart';
import '../test_data_models/test_episode.dart';

/// The double-download race behind today's stuck auto-advance (case study
/// CS-2, oss_player#97): the per-episode download subject in
/// `EpisodeCacheManager` is only registered after two awaits, so two racing
/// `loadNextEpisode` callers each believe they are the first subscriber and
/// each start a full download of the same episode into the same temporary
/// path — the server saw the media fetched twice within the same
/// millisecond (13:20:59.173Z, session fac40073).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    final cacheDir = Directory.systemTemp.createTempSync('podcase-cache-test');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => cacheDir.path,
        );
    addTearDown(() {
      cacheDir.deleteSync(recursive: true);
    });
  });

  test(
    'a shared episode download starts one download for concurrent '
    'subscribers (was: two racing subscribers each started a full download '
    'into the same temp file)',
    () async {
      final spy = SpyEpisodeFileService();
      final manager = EpisodeCacheManager(episodeFileService: spy);

      final episode = fakePlaylistEpisode('239-261014-cache-${DateTime.now().microsecondsSinceEpoch}');

      final sub1Events = <EpisodeFileResponse>[];
      final sub2Events = <EpisodeFileResponse>[];
      final sub1 = manager.download(episode).listen(
            sub1Events.add,
            onError: (Object _) {},
          );
      final sub2 = manager.download(episode).listen(
            sub2Events.add,
            onError: (Object _) {},
          );
      addTearDown(() {
        sub1.cancel();
        sub2.cancel();
      });

      await pumpEventQueue(times: 50);

      // Both callers hit the racing window before any subject got
      // registered; the fix is that the second still joins the first.
      expect(spy.getCalls, 1);

      // The single download feeds both subscribers (no lost tail).
      spy.subjects.single.add(
        RemoteEpisodeFile(remoteUri: episode.url),
      );
      await pumpEventQueue(times: 5);
      expect(sub1Events, isNotEmpty);
      expect(sub2Events, isNotEmpty);
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}

/// Episode-downloader spy: counts `get` (one per real network download) and
/// hands back driveable subjects.
class SpyEpisodeFileService implements EpisodeFileService {
  int getCalls = 0;
  final subjects = <BehaviorSubject<EpisodeFileResponse>>[];

  @override
  BehaviorSubject<EpisodeFileResponse> get(Episode episode, File destination) {
    getCalls++;
    final subject = BehaviorSubject<EpisodeFileResponse>();
    subjects.add(subject);
    return subject;
  }
}
