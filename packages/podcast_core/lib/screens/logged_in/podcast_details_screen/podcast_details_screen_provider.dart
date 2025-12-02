import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/providers/episodes_provider.dart';
import 'package:podcast_core/providers/podcasts_with_status_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'podcast_details_screen_provider.g.dart';

@riverpod
Future<(Podcast, List<EpisodeWithStatus>)> podcastDetailsScreen(
  Ref ref, {
  required PodcastId podcastId,
}) async {
  final podcast = await ref.watch(podcastWithStatusProvider(podcastId).future);
  if (podcast == null) {
    throw Exception('Podcast not found');
  }

  final episodes = await ref.watch(
    episodesWithStatusForPodcastProvider(podcastId: podcastId).future,
  );

  return (podcast.podcast, episodes);
}
