import 'package:dart_mappable/dart_mappable.dart';
import 'package:podcast_core/data/podcast.model.dart';

part 'podcast_with_status.mapper.dart';

@MappableClass()
class PodcastWithStatus with PodcastWithStatusMappable {
  final Podcast podcast;
  final int? episodeCount;
  final int? playedEpisodeCount;
  final bool? hasUnseenEpisodes;

  const PodcastWithStatus({
    required this.podcast,
    required int this.playedEpisodeCount,
    required int this.episodeCount,
    required bool this.hasUnseenEpisodes,
  });

  const PodcastWithStatus.notListened({required this.podcast})
    : episodeCount = null,
      playedEpisodeCount = null,
      hasUnseenEpisodes = null;
}
