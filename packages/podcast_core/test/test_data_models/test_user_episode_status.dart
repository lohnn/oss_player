import 'package:podcast_core/data/user_episode_status.model.dart';

class TestUserEpisodeStatus extends UserEpisodeStatus {
  TestUserEpisodeStatus({
    required super.episodeId,
    super.isPlayed = false,
    required super.currentPosition,
  });
}
