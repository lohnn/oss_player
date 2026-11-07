import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/podcast.model.dart';

/// A `/p/...` link referenced a podcast that cannot be resolved for the
/// current session (unsubscribed feeds are not readable yet — P3 replaces
/// this with preview + subscribe).
final class PodcastNotFoundException implements Exception {
  final PodcastId podcastId;

  const PodcastNotFoundException(this.podcastId);

  @override
  String toString() =>
      'PodcastNotFoundException: no podcast for id "${podcastId.id}"';
}

/// A `/p/.../...` link referenced an episode that does not exist on the
/// (resolvable) podcast.
final class EpisodeNotFoundException implements Exception {
  final EpisodeId episodeId;

  const EpisodeNotFoundException(this.episodeId);

  @override
  String toString() =>
      'EpisodeNotFoundException: no episode for id "${episodeId.id}"';
}

/// Riverpod retry policy for the detail-screen providers: a deterministic
/// not-found never retries (the error screen must surface immediately for a
/// bad deep link), while other failures keep riverpod's documented default
/// envelope — 10 retries, 200 ms doubling, capped at 6.4 s.
Duration? podcastNotFoundAwareRetry(int retryCount, Object error) {
  if (error is PodcastNotFoundException || error is EpisodeNotFoundException) {
    return null;
  }
  if (retryCount >= 10) {
    return null;
  }
  final delay = const Duration(milliseconds: 200) * (1 << retryCount);
  const max = Duration(seconds: 6, milliseconds: 400);

  return delay > max ? max : delay;
}
