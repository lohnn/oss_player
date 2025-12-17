import 'package:collection/collection.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/extensions/list_extension.dart';
import 'package:podcast_core/providers/episodes_provider.dart';
import 'package:podcast_core/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_pod_provider.g.dart';

@Riverpod(keepAlive: true)
class PlaylistPod extends _$PlaylistPod {
  late Repository _repository;

  @override
  Stream<List<Episode>> build() async* {
    _repository = await ref.watch(repositoryProvider.future);

    await for (final queue in _repository.watchPlayQueue()) {
      yield [
        for (final item in queue)
          await ref.read(episodeProvider(item.episodeId).future),
      ];
    }
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final oldQueue = await future;
    state = AsyncData(oldQueue.reorder(oldIndex, newIndex));
    return _recalculateOrder();
  }

  Future<void> _recalculateOrder() async {
    final queue = await future;
    return _repository.updatePlayQueueItemPositions(queue);
  }

  /// Removes the episode from the queue and returns the next episode in the queue
  Future<Episode?> removeFromQueue(Episode episode) async {
    // @TODO: If the episode is currently playing, we should start playing the next episode
    final queue = (await future).toList();
    queue.remove(episode);
    state = AsyncData(queue);

    final queueItem = await _repository.getPlayQueueItem(episode);
    await _repository.deletePlayQueueItem(queueItem);

    await _recalculateOrder();
    return queue.firstOrNull;
  }

  Future<void> addToTopOfQueue(Episode episode) async {
    final queue = (await future).toList();
    // Make sure to put the episode at the top of the queue if it's already in the queue
    queue.remove(episode);
    state = AsyncData([episode, ...queue]);
    return _recalculateOrder();
  }

  Future<void> addToBottomOfQueue(Episode episode) async {
    final queue = await future;
    state = AsyncData([...queue, episode]);
    return _recalculateOrder();
  }
}
