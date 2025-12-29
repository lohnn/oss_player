// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_podcastAudioHandler)
const _podcastAudioHandlerProvider = _PodcastAudioHandlerProvider._();

final class _PodcastAudioHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<PodcastAudioHandler>,
          PodcastAudioHandler,
          FutureOr<PodcastAudioHandler>
        >
    with
        $FutureModifier<PodcastAudioHandler>,
        $FutureProvider<PodcastAudioHandler> {
  const _PodcastAudioHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_podcastAudioHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_podcastAudioHandlerHash();

  @$internal
  @override
  $FutureProviderElement<PodcastAudioHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PodcastAudioHandler> create(Ref ref) {
    return _podcastAudioHandler(ref);
  }
}

String _$_podcastAudioHandlerHash() =>
    r'0c55d813a3e06d8eae6137b10c8163f5b8861f57';

@ProviderFor(_AudioServicePod)
const _audioServicePodProvider = _AudioServicePodProvider._();

final class _AudioServicePodProvider
    extends $AsyncNotifierProvider<_AudioServicePod, PodcastAudioHandler> {
  const _AudioServicePodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_audioServicePodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_audioServicePodHash();

  @$internal
  @override
  _AudioServicePod create() => _AudioServicePod();
}

String _$_audioServicePodHash() => r'166479c7bdc5b280527442922f716103fbf3c856';

abstract class _$AudioServicePod extends $AsyncNotifier<PodcastAudioHandler> {
  FutureOr<PodcastAudioHandler> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<PodcastAudioHandler>, PodcastAudioHandler>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PodcastAudioHandler>, PodcastAudioHandler>,
              AsyncValue<PodcastAudioHandler>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AudioPlayerPod)
const audioPlayerPodProvider = AudioPlayerPodProvider._();

final class AudioPlayerPodProvider
    extends $AsyncNotifierProvider<AudioPlayerPod, Episode?> {
  const AudioPlayerPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioPlayerPodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioPlayerPodHash();

  @$internal
  @override
  AudioPlayerPod create() => AudioPlayerPod();
}

String _$audioPlayerPodHash() => r'f7322591d0eb0a544af454cb90854920424d511f';

abstract class _$AudioPlayerPod extends $AsyncNotifier<Episode?> {
  FutureOr<Episode?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Episode?>, Episode?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Episode?>, Episode?>,
              AsyncValue<Episode?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentPosition)
const currentPositionProvider = CurrentPositionProvider._();

final class CurrentPositionProvider
    extends
        $FunctionalProvider<
          AsyncValue<
            ({Duration buffered, Duration? duration, Duration position})
          >,
          ({Duration buffered, Duration? duration, Duration position}),
          Stream<({Duration buffered, Duration? duration, Duration position})>
        >
    with
        $FutureModifier<
          ({Duration buffered, Duration? duration, Duration position})
        >,
        $StreamProvider<
          ({Duration buffered, Duration? duration, Duration position})
        > {
  const CurrentPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPositionHash();

  @$internal
  @override
  $StreamProviderElement<
    ({Duration buffered, Duration? duration, Duration position})
  >
  $createElement($ProviderPointer pointer) => $StreamProviderElement(pointer);

  @override
  Stream<({Duration buffered, Duration? duration, Duration position})> create(
    Ref ref,
  ) {
    return currentPosition(ref);
  }
}

String _$currentPositionHash() => r'121418eca53c2cdd41fafe65950495adc61300eb';

@ProviderFor(audioState)
const audioStateProvider = AudioStateProvider._();

final class AudioStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlaybackState>,
          PlaybackState,
          Stream<PlaybackState>
        >
    with $FutureModifier<PlaybackState>, $StreamProvider<PlaybackState> {
  const AudioStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioStateHash();

  @$internal
  @override
  $StreamProviderElement<PlaybackState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PlaybackState> create(Ref ref) {
    return audioState(ref);
  }
}

String _$audioStateHash() => r'8f700801439f1fd64e400b937b16182b7ea75bd8';
