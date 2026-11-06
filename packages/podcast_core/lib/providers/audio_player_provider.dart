import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:logging/logging.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/providers/app_lifecycle_state_provider.dart';
import 'package:podcast_core/providers/playlist_pod_provider.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/services/logging/log_sink.dart';
import 'package:podcast_core/services/logging/log_sink_provider.dart';
import 'package:podcast_core/services/podcast_audio_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_player_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PodcastAudioHandler> _podcastAudioHandler(Ref ref) async {
  final audioSession = await AudioSession.instance;
  await audioSession.configure(const AudioSessionConfiguration.speech());
  return PodcastAudioHandler(
    audioSession: audioSession,
    repository: await ref.watch(repositoryProvider.future),
  );
}

@Riverpod(keepAlive: true)
class _AudioServicePod extends _$AudioServicePod {
  @override
  Future<PodcastAudioHandler> build() {
    return _initService();
  }

  Future<PodcastAudioHandler> _initService() async {
    final podcastAudioHandler = await ref.watch(
      _podcastAudioHandlerProvider.future,
    );

    return AudioService.init(
      builder: () => podcastAudioHandler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'se.lohnn.podcast.audio',
        androidNotificationChannelName: 'Lohnn Podcast',
        // @TODO: These two settings can cause the operating system to kill the app
        androidNotificationOngoing: true,
        // androidStopForegroundOnPause: false,
        androidNotificationIcon: 'drawable/podcast_icon_outline',
      ),
    );
  }
}

@Riverpod(keepAlive: true)
class AudioPlayerPod extends _$AudioPlayerPod {
  late PodcastAudioHandler _player;
  late Repository _repository;
  late LogSink _logSink;

  final _log = Logger('se.lohnn.podcast.AudioPlayerPod');

  @override
  Future<Episode?> build() async {
    _logSink = ref.watch(logSinkProvider);
    try {
      _player = await ref.watch(_audioServicePodProvider.future);
      _repository = await ref.watch(repositoryProvider.future);

      final subscription = _player.episodeFinished.listen((_) {
        _onEpisodeFinished();
      });
      ref.onDispose(subscription.cancel);

      // Initial setup of the queue
      ref.listen(playlistPodProvider, (oldState, newState) {
        final queue = newState.value ?? [];
        updateQueue(queue);
      });
      // ref.read(playlistPodProvider.future).then(updateQueue);

      ref.listen(appLifecycleStatePodProvider, (_, state) {
        if (state == AppLifecycleState.paused) {
          timeStopPlaying();
        }
      });

      return future;
    } catch (e, stackTrace) {
      _logSink.reportError(
        e,
        stackTrace,
        name: 'AudioPlayerPod',
        message: 'Audio player build failed',
      );
      rethrow;
    }
  }

  Future<void> updateQueue(List<Episode> queue) async {
    try {
      if (queue.isNotEmpty) {
        await _player.setQueue(queue);

        final nextEpisode = queue.firstOrNull;
        if (nextEpisode != null) {
          if (nextEpisode.id == state.value?.id) return;

          await loadNextEpisode(nextEpisode);
          state = AsyncData(nextEpisode);
        } else {
          state = const AsyncData(null);
        }
      } else {
        state = const AsyncData(null);
      }
    } catch (e, stackTrace) {
      _logSink.reportError(
        e,
        stackTrace,
        name: 'AudioPlayerPod',
        message: 'updateQueue failed',
        context: {'queue_length': queue.length},
      );
      state = AsyncError(e, stackTrace);
      rethrow;
    }
  }

  /// In-flight next-episode loads, single-flight per episode (CS-2,
  /// oss_player#97): during the end-of-episode transition the playlist echo
  /// (`updateQueue`, via `removeFromQueue`'s re-emission) and `playEpisode`
  /// both request the same next episode milliseconds apart. Racing callers
  /// join the shared load; the strongest play intent wins.
  final Map<String, _EpisodeLoadFlight> _inFlightLoads = {};

  /// Loads the next episode and starts playing it.
  ///
  /// If [autoPlay] is set to true, the episode will start playing immediately.
  /// If [autoPlay] is set to false, the episode will be loaded but not played.
  ///
  /// The load is direct: the persisted status is read exactly once and the
  /// episode's remote URL becomes THE audio source (implicit full-episode
  /// downloads are gone — the app streams directly; a future explicit
  /// download can be added on top of this simpler floor when offline
  /// playback comes back as a real feature).
  ///
  /// Loads are single-flight per episode: a concurrent request for the same
  /// episode joins the load that is already running instead of racing it,
  /// and the strongest play intent among the racing callers wins.
  ///
  /// Returns a future that completes when the episode has been loaded, or
  /// completes with the error that failed the load — failures are also
  /// reported through the [LogSink] (they used to be swallowed here,
  /// leaving the player on the finished episode).
  Future<void> loadNextEpisode(Episode episode, {bool autoPlay = false}) {
    final episodeKey = episode.id.id;
    final inFlight = _inFlightLoads[episodeKey];
    if (inFlight case final flight?) {
      // Join the running load; never restart it.
      if (autoPlay) flight.requestPlay = true;
      if (flight.isCompleted) {
        // The shared load already applied, possibly before this join
        // upgraded the play intent — start playback now, the same way
        // playEpisode does after a fresh load.
        return _playIfRequested(flight);
      }
      return flight.future;
    }

    final flight = _EpisodeLoadFlight()..requestPlay = autoPlay;
    _inFlightLoads[episodeKey] = flight;
    final completer = flight.completer;

    void forgetFlight() {
      if (_inFlightLoads[episodeKey] == flight) {
        _inFlightLoads.remove(episodeKey);
      }
    }

    _applyEpisodeLoad(
      episode,
      flight: flight,
      completer: completer,
      forgetFlight: forgetFlight,
    );

    return completer.future;
  }

  /// The single streaming load behind one flight: read the persisted status
  /// and drive the player directly. Racing callers never get a second one
  /// (they join the flight), so errors and completion — including the
  /// silent-failure family this exact shape used to produce — land on the
  /// awaiters and the [LogSink], never on a done event.
  Future<void> _applyEpisodeLoad(
    Episode episode, {
    required _EpisodeLoadFlight flight,
    required Completer<void> completer,
    required void Function() forgetFlight,
  }) async {
    try {
      final status = await _getStatusForEpisode(episode);
      await _player.loadEpisode(
        episode,
        episodeUri: episode.url,
        status: status,
        autoPlay: flight.requestPlay,
      );
      // A racing caller may have upgraded the play intent while this load
      // was applying — and the handler's same-URI guard (blindly correct:
      // never RE-load the active source) skips its own auto-play, so the
      // intent must be honoured here or the next episode sat loaded but
      // never started (the CS-2 symptom). One re-assertion per flight is
      // safe: the per-progress-tick flood that made `if (autoPlay) play()`
      // undo explicit pauses in CS-1 is structurally gone — one load per
      // episode transition, ever.
      if (flight.requestPlay && !_player.isPlaying) {
        await _player.play();
      }
      if (!completer.isCompleted) {
        completer.complete();
      }
    } catch (e, stackTrace) {
      _reportFailedLoad(episode.id.id, e, stackTrace);
      if (!completer.isCompleted) {
        completer.completeError(e, stackTrace);
      }
    } finally {
      forgetFlight();
    }
  }

  void _reportFailedLoad(String episodeKey, Object e, StackTrace stackTrace) {
    _logSink.reportError(
      e,
      stackTrace,
      name: 'se.lohnn.podcast.AudioPlayerPod',
      message: 'Episode load failed',
      context: {'episode_id': episodeKey},
    );
  }

  /// Starts playback when the joined play intent says so but the shared load
  /// ran before the intent was upgraded.
  Future<void> _playIfRequested(_EpisodeLoadFlight flight) {
    if (flight.requestPlay && !_player.isPlaying) {
      return _player.play();
    }
    return Future<void>.value();
  }

  Future<EpisodeWithStatus> _getStatusForEpisode(Episode episode) async {
    final status = await _repository.getUserEpisodeStatus(episode);
    return EpisodeWithStatus(episode: episode, status: status);
  }

  Future<void> _onEpisodeFinished() async {
    final episode = await future;

    _log.fine('Episode finished: ${episode!.title}');

    await _player.stop();

    // Set listened to true in episode
    await _repository.markEpisodeListened(episode.id);

    // Remove episode reference from user
    final nextItem = await ref
        .read(playlistPodProvider.notifier)
        .removeFromQueue(episode);

    // Start next episode from queue? (if not automatic)
    if (nextItem case final nextItem?) {
      await playEpisode(nextItem);
    } else {
      _player.clearPlaying();
      state = const AsyncData(null);
    }
  }

  Future<void> playEpisode(Episode episode, {bool autoPlay = true}) async {
    state = AsyncData(episode);

    await ref.read(playlistPodProvider.notifier).addToTopOfQueue(episode);

    await loadNextEpisode(episode, autoPlay: autoPlay);

    if (autoPlay) await _player.play();
  }

  void triggerMediaAction(MediaAction action) => switch (action) {
    MediaAction.playPause =>
      switch (_player.playbackState.valueOrNull?.playing ?? false) {
        true => _player.pause(),
        false => _player.play(),
      },
    MediaAction.play => _player.play(),
    MediaAction.pause => _player.pause(),
    MediaAction.stop => _player.stop(),
    MediaAction.fastForward => _player.fastForward(),
    MediaAction.skipToNext => _player.fastForward(),
    MediaAction.rewind => _player.rewind(),
    MediaAction.skipToPrevious => _player.rewind(),
    _ => throw UnsupportedError('Action $action not supported yet.'),
  };

  void seekRelative(Duration offset) {
    _player.seekRelative(offset);
  }

  void setPosition(int positionInMillis) {
    _player.seek(Duration(milliseconds: positionInMillis));
  }

  /// Stops the player and disposes stream after delay if the player is not
  /// playing.
  void timeStopPlaying() {
    if (_player.isPlaying) return;
    _player.timeStop();
  }

  Future<void> dispose() => _player.dispose();
}

@riverpod
Stream<({Duration position, Duration buffered, Duration? duration})>
currentPosition(Ref ref) async* {
  final audioPlayer = await ref.watch(_audioServicePodProvider.future);
  yield* audioPlayer.positionStream;
}

@riverpod
Stream<PlaybackState> audioState(Ref ref) async* {
  final audioPlayer = await ref.watch(_audioServicePodProvider.future);
  yield* audioPlayer.playbackState;
}

/// One episode-load attempt, joinable by concurrent callers (CS-2).
///
/// [requestPlay] carries the strongest `autoPlay` intent seen among the
/// racing callers — `updateQueue`'s echo loads with `autoPlay: false` while
/// `playEpisode` wants playback; the shared load reads the flag at event
/// time so a later join still gets music, not a paused episode.
class _EpisodeLoadFlight {
  bool requestPlay = false;

  final Completer<void> _completer = Completer<void>();

  Completer<void> get completer => _completer;

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;
}
