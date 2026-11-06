import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/providers/playlist_pod_provider.dart';

import '../test_data_models/test_episode.dart';

/// Test seam for the play-queue stream (the CS-2 / oss_player#97 seam).
///
/// The production `PlaylistPod` mirrors a backend table and re-emits its list
/// from `watchPlayQueue()` and from every queue mutation. During an
/// end-of-episode transition those mutations (`removeFromQueue`, then
/// `addToTopOfQueue`) round-trip the network, and each re-emission drives
/// `AudioPlayerPod.updateQueue` — the source of the racing next-episode load.
///
/// This fake preserves that shape: synchronous list mutation + a state
/// re-emission (which riverpod delivers to the pod's `ref.listen`), with an
/// optional test-controlled gate standing in for the backend round-trip so a
/// test can interleave download events exactly where the incident's network
/// latency put them.
class FakePlaylistPod extends PlaylistPod {
  final List<Episode> queue;

  /// When set, [removeFromQueue] parks until completed, like the real
  /// DELETE/re-POST churn between the queue mutation and returning the next
  /// item.
  Completer<void>? removeFromQueueGate;

  /// Same for [addToTopOfQueue].
  Completer<void>? addToTopOfQueueGate;

  FakePlaylistPod([List<Episode>? initialQueue]) : queue = [...?initialQueue];

  @override
  Stream<List<Episode>> build() async* {
    yield List.of(queue);
  }

  @override
  Future<Episode?> removeFromQueue(Episode episode) async {
    queue.remove(episode);
    state = AsyncData(List.of(queue));

    if (removeFromQueueGate case final gate?) await gate.future;
    return queue.firstOrNull;
  }

  @override
  Future<void> addToTopOfQueue(Episode episode) async {
    queue
      ..remove(episode)
      ..insert(0, episode);
    state = AsyncData(List.of(queue));

    if (addToTopOfQueueGate case final gate?) await gate.future;
  }
}

/// Convenience builder mirroring `TestEpisode`.
Episode fakePlaylistEpisode(String id) => TestEpisode(
      id: EpisodeId(id),
      url: Uri.parse('https://media.example.com/$id.mp3'),
      title: 'Test episode $id',
      imageUrl: Uri.parse('https://127.0.0.1:1/art-$id.jpg'),
      podcastId: PodcastId('test-podcast'),
      duration: const Duration(minutes: 47),
    );
