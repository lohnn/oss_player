import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/providers/episode_load_sequencer.dart';
import 'package:podcast_core/providers/episode_loader_provider.dart';

import '../test_data_models/test_episode.dart';

/// The auto-advance pause bug, sequencer side: previously one persisted
/// status read and one player load ran per download progress tick — ~9,000
/// reads over ~28 s during a single episode transition (observed from the
/// incident's server-side request logs).
void main() {
  final episode = TestEpisode(
    id: EpisodeId('236-260904'),
    url: Uri.parse('https://media.example.com/236_260904.mp3'),
    title: 'Test episode 236',
    imageUrl: Uri.parse('https://example.com/art.jpg'),
    podcastId: PodcastId('test-podcast'),
    duration: const Duration(minutes: 47),
  );

  final remote = Uri.parse('https://media.example.com/236_260904.mp3');
  final local = Uri.parse('file:///cache/episodes/236_260904.mp3');

  EpisodeLoadSequencer buildSequencer(
    List<Uri> loads, {
    required void Function() onStatusFetch,
  }) {
    return EpisodeLoadSequencer(
      loadStatus: () async {
        onStatusFetch();
        return EpisodeWithStatus(episode: episode, status: null);
      },
      load: ({required episodeUri, required status, required autoPlay}) async {
        loads.add(episodeUri);
      },
    );
  }

  test(
    'handleFileResponse: repeated same-URI progress events fetch status and '
    'load once (was: once per progress chunk)',
    () async {
      final loads = <Uri>[];
      var statusFetches = 0;
      final sequencer = buildSequencer(
        loads,
        onStatusFetch: () => statusFetches++,
      );

      // One initial remote event + dio-dense progress ticks (all same URI).
      for (var i = 0; i <= 500; i++) {
        await sequencer.handleFileResponse(
          RemoteEpisodeFile(remoteUri: remote),
          autoPlay: true,
        );
      }

      // Incident signature would be 501 status fetches and 501 loads.
      expect(
        statusFetches,
        1,
        reason:
            'Every download progress tick must not trigger a persisted '
            'status read (incident signature: ~9,000 reads in ~28 s)',
      );
      expect(
        loads,
        hasLength(1),
        reason: 'The player must not be re-driven per progress tick',
      );
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );

  test(
    'handleFileResponse: a changed URI (cache takeover) applies once, with '
    'its own status fetch',
    () async {
      final loads = <Uri>[];
      var statusFetches = 0;
      final sequencer = buildSequencer(
        loads,
        onStatusFetch: () => statusFetches++,
      );

      await sequencer.handleFileResponse(
        RemoteEpisodeFile(remoteUri: remote),
        autoPlay: true,
      );
      for (var i = 0; i < 100; i++) {
        await sequencer.handleFileResponse(
          RemoteEpisodeFile(remoteUri: remote),
          autoPlay: true,
        );
      }
      await sequencer.handleFileResponse(
        LocalEpisodeFile(remoteUri: remote, localUri: local),
        autoPlay: true,
      );

      expect(
        statusFetches,
        2,
        reason: 'One fetch per URI transition: initial remote, then takeover',
      );
      expect(loads, [remote, local]);
    },
    timeout: const Timeout(Duration(seconds: 30)),
  );
}
