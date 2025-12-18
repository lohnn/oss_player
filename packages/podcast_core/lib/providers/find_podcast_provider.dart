import 'package:flutter/foundation.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/data/podcast_search.model.dart';
import 'package:podcast_core/helpers/debouncer.dart';
import 'package:podcast_core/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'find_podcast_provider.g.dart';

@riverpod
class FindPodcast extends _$FindPodcast {
  final _searchDebouncer = Debouncer.long();
  late Repository _repository;
  late bool _mounted;

  @override
  Future<List<PodcastSearch>> build() async {
    _repository = await ref.watch(repositoryProvider.future);
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    try {
      return _repository.findPodcasts();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> search(String searchTerm, {bool skipDebounce = false}) async {
    state = const AsyncLoading();

    Future<void> runFindPodcast() async {
      try {
        final podcasts = await _repository.findPodcasts(searchTerm);

        if (_mounted) state = AsyncData(podcasts);
      } catch (e, stackTrace) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);

        if (_mounted) state = AsyncError(e, stackTrace);
      }
    }

    if (skipDebounce) {
      _searchDebouncer.cancel();
      return runFindPodcast();
    }
    _searchDebouncer.run(runFindPodcast);
  }

  Future<void> subscribe(PodcastRssUrl podcast) async {
    await _repository.subscribeToPodcast(podcast);
  }

  Future<void> unsubscribe(PodcastRssUrl podcast) {
    return _repository.unsubscribeFromPodcast(podcast);
  }
}
