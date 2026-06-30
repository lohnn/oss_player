import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/data/podcast_search.model.dart';
import 'package:podcast_core/helpers/debouncer.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/services/logging/log_sink.dart';
import 'package:podcast_core/services/logging/log_sink_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'find_podcast_provider.g.dart';

@riverpod
class FindPodcast extends _$FindPodcast {
  final _searchDebouncer = Debouncer.long();
  late Repository _repository;
  late LogSink _logSink;
  late bool _mounted;

  @override
  Future<List<PodcastSearch>> build() async {
    _logSink = ref.watch(logSinkProvider);
    _repository = await ref.watch(repositoryProvider.future);
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    try {
      return _repository.findPodcasts();
    } catch (e, stackTrace) {
      _logSink.reportError(
        e,
        stackTrace,
        name: 'FindPodcast',
        message: 'Initial findPodcasts failed',
      );
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
        _logSink.reportError(
          e,
          stackTrace,
          name: 'FindPodcast',
          message: 'findPodcasts search failed',
          context: {'search_term': searchTerm},
        );

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
