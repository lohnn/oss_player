// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_pod_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlaylistPod)
const playlistPodProvider = PlaylistPodProvider._();

final class PlaylistPodProvider
    extends $StreamNotifierProvider<PlaylistPod, List<Episode>> {
  const PlaylistPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playlistPodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playlistPodHash();

  @$internal
  @override
  PlaylistPod create() => PlaylistPod();
}

String _$playlistPodHash() => r'b286c83a6e36c715696d1b0c1ecc54ee9054ecaa';

abstract class _$PlaylistPod extends $StreamNotifier<List<Episode>> {
  Stream<List<Episode>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Episode>>, List<Episode>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Episode>>, List<Episode>>,
              AsyncValue<List<Episode>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
