import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/providers/episode_loader_provider.dart';

/// Drives what happens for each [EpisodeFileResponse] event emitted while an
/// episode is being loaded (remote stream, download progress ticks, and the
/// final cache takeover).
///
/// Counters are exposed for tests:
/// - [statusFetchCount]: how many times the persisted playback status was read.
/// - [appliedLoadCount]: how many times the player load was invoked.
class EpisodeLoadSequencer {
  final Future<EpisodeWithStatus> Function() loadStatus;
  final Future<void> Function({
    required Uri episodeUri,
    required EpisodeWithStatus status,
    required bool autoPlay,
  })
  load;

  int _statusFetchCount = 0;
  int _appliedLoadCount = 0;
  Uri? _lastAppliedUri;

  factory EpisodeLoadSequencer({
    required Future<EpisodeWithStatus> Function() loadStatus,
    required Future<void> Function({
      required Uri episodeUri,
      required EpisodeWithStatus status,
      required bool autoPlay,
    })
    load,
  }) => EpisodeLoadSequencer._(
    loadStatus: loadStatus,
    load: load,
  );

  EpisodeLoadSequencer._({required this.loadStatus, required this.load});

  /// How many times the download-sequence had to read the persisted status.
  int get statusFetchCount => _statusFetchCount;

  /// How many times the player was actually driven to (re)load a source.
  int get appliedLoadCount => _appliedLoadCount;

  /// The download stream has produced a new [fileResponse]. Downloader
  /// progress events repeat the same URI for every chunk; only a URI
  /// transition (first appearance, or the cache switching to a local file)
  /// means something changed. Repetitions are ignored — before this, every
  /// event re-read the persisted status and re-drove the player, peaking at
  /// ~330 reads/s during downloads.
  Future<void> handleFileResponse(
    EpisodeFileResponse fileResponse, {
    required bool autoPlay,
  }) async {
    final uri = fileResponse.currentUri;
    if (uri == _lastAppliedUri) return;
    _lastAppliedUri = uri;

    final status = await loadStatus();
    _statusFetchCount++;
    await load(episodeUri: uri, status: status, autoPlay: autoPlay);
    _appliedLoadCount++;
  }
}
