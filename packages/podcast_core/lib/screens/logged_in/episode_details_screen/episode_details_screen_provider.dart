import 'package:collection/collection.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/exceptions/not_found_exceptions.dart';
import 'package:podcast_core/providers/episodes_provider.dart';
import 'package:podcast_core/providers/podcasts_with_status_provider.dart';
import 'package:podcast_core/services/logging/log_sink_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'episode_details_screen_provider.g.dart';

@Riverpod(retry: podcastNotFoundAwareRetry)
Future<(Podcast, EpisodeWithStatus)> episodeDetailsScreen(
  Ref ref, {
  required PodcastId podcastId,
  required EpisodeId episodeId,
}) async {
  final episode = await ref
      .watch(episodesWithStatusForPodcastProvider(podcastId: podcastId).future)
      .then(
        (episodes) => episodes.firstWhereOrNull(
          (episodeWithStatus) => episodeWithStatus.episode.id == episodeId,
        ),
      );
  if (episode == null) {
    final error = EpisodeNotFoundException(episodeId);
    ref.read(logSinkProvider).reportError(
          error,
          StackTrace.current,
          name: 'EpisodeDetailsScreenProvider',
          message: 'Episode not found for linked id',
          context: {'podcast_id': podcastId.id, 'episode_id': episodeId.id},
        );
    throw error;
  }

  final podcast = await ref.watch(podcastWithStatusProvider(podcastId).future);
  if (podcast != null) {
    return (podcast.podcast, episode);
  }

  final error = PodcastNotFoundException(podcastId);
  ref.read(logSinkProvider).reportError(
        error,
        StackTrace.current,
        name: 'EpisodeDetailsScreenProvider',
        message: 'Podcast not found for linked id',
        context: {'podcast_id': podcastId.id},
      );
  throw error;
}
