import 'dart:async';

import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';

/// Records every platform call the real plugin would make, so tests can
/// assert on player behavior without Android/iOS. Pump [emitEvent] to push
/// playback state through the real `just_audio` `AudioPlayer` state machine.
///
/// Deliberately minimal: load/play/pause/seek + the event stream. Any other
/// call surfaces as the interface's default `UnimplementedError`, failing the
/// test loudly instead of silently no-oping.
class FakeJustAudioPlatform extends JustAudioPlatform {
  final FakePlatformAudioPlayer player;

  FakeJustAudioPlatform() : player = FakePlatformAudioPlayer('test-player');

  @override
  Future<AudioPlayerPlatform> init(InitRequest request) async => player;

  @override
  Future<DisposePlayerResponse> disposePlayer(
    DisposePlayerRequest request,
  ) async => DisposePlayerResponse();
}

class FakePlatformAudioPlayer extends AudioPlayerPlatform {
  int loadCount = 0;
  int playCount = 0;
  int pauseCount = 0;
  final List<Uri> loadedUris = [];
  final List<Duration?> loadedInitialPositions = [];
  final List<Duration> seekPositions = [];

  /// Duration every successful [load] reports back to the player.
  Duration fakeDuration = const Duration(hours: 2);

  /// Current position reported via [emitEvent].
  Duration fakePosition = Duration.zero;

  final _eventController = StreamController<PlaybackEventMessage>.broadcast();

  FakePlatformAudioPlayer(super.id);

  @override
  Stream<PlaybackEventMessage> get playbackEventMessageStream =>
      _eventController.stream;

  Uri? get lastLoadedUri => loadedUris.isEmpty ? null : loadedUris.last;

  /// Pushes a playback event into the player's state machine, like the
  /// platform side would.
  void emitEvent({ProcessingStateMessage state = ProcessingStateMessage.ready}) {
    _eventController.add(
      PlaybackEventMessage(
        processingState: state,
        updateTime: DateTime.now(),
        updatePosition: fakePosition,
        bufferedPosition: fakeDuration,
        duration: fakeDuration,
        icyMetadata: null,
        currentIndex: 0,
        androidAudioSessionId: null,
      ),
    );
  }

  @override
  Future<LoadResponse> load(LoadRequest request) async {
    loadCount++;
    // just_audio wraps even a single source in a (playlist) concatenating
    // message; the real source is its first child.
    var effective = request.audioSourceMessage;
    if (effective case ConcatenatingAudioSourceMessage(children: final children)
        when children.isNotEmpty) {
      effective = children.first;
    }
    final uri = switch (effective) {
      ProgressiveAudioSourceMessage(:final uri) => Uri.parse(uri),
      _ => throw StateError(
        'FakePlatformAudioPlayer only supports progressive sources, '
        'got ${effective.runtimeType}',
      ),
    };
    loadedUris.add(uri);
    loadedInitialPositions.add(request.initialPosition);
    fakePosition = request.initialPosition ?? Duration.zero;
    emitEvent();
    return LoadResponse(duration: fakeDuration);
  }

  @override
  Future<PlayResponse> play(PlayRequest request) async {
    playCount++;
    emitEvent();
    return PlayResponse();
  }

  @override
  Future<PauseResponse> pause(PauseRequest request) async {
    pauseCount++;
    emitEvent();
    return PauseResponse();
  }

  @override
  Future<SeekResponse> seek(SeekRequest request) async {
    final position = request.position ?? Duration.zero;
    seekPositions.add(position);
    fakePosition = position;
    emitEvent();
    return SeekResponse();
  }

  @override
  Future<SetLoopModeResponse> setLoopMode(SetLoopModeRequest request) async =>
      SetLoopModeResponse();

  @override
  Future<SetShuffleModeResponse> setShuffleMode(
    SetShuffleModeRequest request,
  ) async => SetShuffleModeResponse();

  @override
  Future<SetSkipSilenceResponse> setSkipSilence(
    SetSkipSilenceRequest request,
  ) async => SetSkipSilenceResponse();

  @override
  Future<AudioEffectSetEnabledResponse> audioEffectSetEnabled(
    AudioEffectSetEnabledRequest request,
  ) async => AudioEffectSetEnabledResponse();

  @override
  Future<SetAndroidAudioAttributesResponse> setAndroidAudioAttributes(
    SetAndroidAudioAttributesRequest request,
  ) async => SetAndroidAudioAttributesResponse();

  @override
  Future<ConcatenatingInsertAllResponse> concatenatingInsertAll(
    ConcatenatingInsertAllRequest request,
  ) async => ConcatenatingInsertAllResponse();

  @override
  Future<ConcatenatingRemoveRangeResponse> concatenatingRemoveRange(
    ConcatenatingRemoveRangeRequest request,
  ) async => ConcatenatingRemoveRangeResponse();

  @override
  Future<ConcatenatingMoveResponse> concatenatingMove(
    ConcatenatingMoveRequest request,
  ) async => ConcatenatingMoveResponse();

  @override
  Future<SetShuffleOrderResponse> setShuffleOrder(
    SetShuffleOrderRequest request,
  ) async => SetShuffleOrderResponse();

  @override
  Future<SetVolumeResponse> setVolume(SetVolumeRequest request) async =>
      SetVolumeResponse();

  @override
  Future<SetSpeedResponse> setSpeed(SetSpeedRequest request) async =>
      SetSpeedResponse();

  @override
  Future<DisposeResponse> dispose(DisposeRequest request) async =>
      DisposeResponse();
}
