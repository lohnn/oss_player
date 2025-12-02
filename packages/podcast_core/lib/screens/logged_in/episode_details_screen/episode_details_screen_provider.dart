import 'package:collection/collection.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/providers/episodes_provider.dart';
import 'package:podcast_core/providers/podcasts_with_status_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'episode_details_screen_provider.g.dart';

@riverpod
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
    throw Exception('Episode not found');
  }

  final podcast = await ref.watch(podcastWithStatusProvider(podcastId).future);
  if (podcast != null) {
    return (podcast.podcast, episode);
  }
  throw Exception('Podcast not found');
}
