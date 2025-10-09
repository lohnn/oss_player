import 'package:podcast_core/data/episode.model.dart';

abstract class PlayQueueItem {
  EpisodeId get episodeId;

  int get queueOrder;
}
