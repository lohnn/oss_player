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

  // Assigned by build(); search can legitimately arrive (deep-search links
  // seed + search from a post-frame callback) before build()'s repository
  // await has resumed, so it stays nullable instead of `late`.
  Repository? _repository;
  late LogSink _logSink;

  // True from notifier construction; build() only arms the disposal flag.
  bool _mounted = true;

  @override
  Future<List<PodcastSearch>> build() async {
    _logSink = ref.watch(logSinkProvider);
    final repository = await ref.watch(repositoryProvider.future);
    _repository = repository;
    ref.onDispose(() => _mounted = false);
    try {
      return repository.findPodcasts();
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
        final podcasts = await (await _repositoryOrBuild()).findPodcasts(
          searchTerm,
        );

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
    await (await _repositoryOrBuild()).subscribeToPodcast(podcast);
  }

  Future<void> unsubscribe(PodcastRssUrl podcast) async {
    return (await _repositoryOrBuild()).unsubscribeFromPodcast(podcast);
  }

  /// build() awaits the repository asynchronously; callers that can race it
  /// (a deep-link seeded search fires from a post-frame callback) fall back
  /// to reading the same future instead of touching a barely-`late` field.
  Future<Repository> _repositoryOrBuild() async {
    final assigned = _repository;
    return assigned ?? await ref.read(repositoryProvider.future);
  }
}
