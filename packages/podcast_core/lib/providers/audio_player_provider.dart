import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:logging/logging.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/providers/app_lifecycle_state_provider.dart';
import 'package:podcast_core/providers/episode_load_sequencer.dart';
import 'package:podcast_core/providers/episode_loader_provider.dart';
import 'package:podcast_core/providers/playlist_pod_provider.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/services/logging/log_sink.dart';
import 'package:podcast_core/services/logging/log_sink_provider.dart';
import 'package:podcast_core/services/podcast_audio_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

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

  StreamSubscription<EpisodeFileResponse>? _downloadSubscription;

  /// In-flight next-episode loads, single-flight per episode (CS-2,
  /// oss_player#97): during the end-of-episode transition the playlist echo
  /// (`updateQueue`, via `removeFromQueue`'s re-emission) and `playEpisode`
  /// both request the same next episode milliseconds apart. The second call
  /// used to cancel and restart the first one's download — the server saw
  /// the media fetched twice within the same millisecond — and whichever
  /// load happened to run last decided the play state: when the echo's
  /// `autoPlay: false` ran, the next episode loaded but never started.
  final Map<String, _EpisodeLoadFlight> _inFlightLoads = {};

  /// Loads the next episode in the queue and starts playing it.
  ///
  /// If [autoPlay] is set to true, the episode will start playing immediately.
  /// If [autoPlay] is set to false, the episode will be loaded but not played.
  ///
  /// It will check for already downloaded episodes and start playing it. If
  /// the episode is not downloaded, it will start downloading it.
  ///
  /// Loads are single-flight per episode: a concurrent request for the same
  /// episode joins the load that is already running instead of restarting it,
  /// and the strongest play intent among the racing callers wins.
  ///
  /// Returns a future that completes when the episode has been loaded from
  /// the first source, or completes with the error that failed the load —
  /// failures are also reported through the [LogSink] (they used to be
  /// swallowed here, leaving the player on the finished episode).
  Future<void> loadNextEpisode(Episode episode, {bool autoPlay = false}) {
    final episodeKey = episode.id.id;
    final inFlight = _inFlightLoads[episodeKey];
    if (inFlight case final flight?) {
      // Join the running load; never restart the download.
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

    _downloadSubscription?.cancel();

    // The download stream emits one event per progress tick. The sequencer
    // collapses repeats of the same URI, so the status is read and the player
    // is loaded once per URI transition — not per tick.
    final sequencer = EpisodeLoadSequencer(
      loadStatus: () => _getStatusForEpisode(episode),
      load: ({
        required Uri episodeUri,
        required EpisodeWithStatus status,
        required bool autoPlay,
      }) =>
          _player.loadEpisode(
            episode,
            episodeUri: episodeUri,
            status: status,
            autoPlay: autoPlay,
          ),
    );

    _downloadSubscription = ref
        .read(episodeLoaderProvider(episode).notifier)
        .tryDownload()
        .doOnCancel(() {
          if (!completer.isCompleted) {
            completer.complete();
          }
          forgetFlight();
        })
        .listen(
          (fileResponse) async {
            try {
              await sequencer.handleFileResponse(
                fileResponse,
                autoPlay: flight.requestPlay,
              );
            } catch (e, stackTrace) {
              _reportFailedLoad(episodeKey, e, stackTrace);
              if (!completer.isCompleted) {
                completer.completeError(e, stackTrace);
              }
              forgetFlight();
              return;
            }
            if (!completer.isCompleted) {
              completer.complete();
            }
          },
          onError: (Object e, StackTrace stackTrace) {
            _reportFailedLoad(episodeKey, e, stackTrace);
            if (!completer.isCompleted) {
              completer.completeError(e, stackTrace);
            }
            forgetFlight();
          },
          onDone: () {
            if (!completer.isCompleted) {
              completer.complete();
            }
            forgetFlight();
          },
        );

    return completer.future;
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
