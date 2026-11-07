import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/exceptions/not_found_exceptions.dart';
import 'package:podcast_core/providers/episodes_provider.dart';
import 'package:podcast_core/providers/podcasts_with_status_provider.dart';
import 'package:podcast_core/services/logging/log_sink_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'podcast_details_screen_provider.g.dart';

@Riverpod(retry: podcastNotFoundAwareRetry)
Future<(Podcast, List<EpisodeWithStatus>)> podcastDetailsScreen(
  Ref ref, {
  required PodcastId podcastId,
}) async {
  final podcast = await ref.watch(podcastWithStatusProvider(podcastId).future);
  if (podcast == null) {
    final error = PodcastNotFoundException(podcastId);
    ref.read(logSinkProvider).reportError(
          error,
          StackTrace.current,
          name: 'PodcastDetailsScreenProvider',
          message: 'Podcast not found for linked id',
          context: {'podcast_id': podcastId.id},
        );
    throw error;
  }

  final episodes = await ref.watch(
    episodesWithStatusForPodcastProvider(podcastId: podcastId).future,
  );

  return (podcast.podcast, episodes);
}
