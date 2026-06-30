// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_podcast_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FindPodcast)
const findPodcastProvider = FindPodcastProvider._();

final class FindPodcastProvider
    extends $AsyncNotifierProvider<FindPodcast, List<PodcastSearch>> {
  const FindPodcastProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'findPodcastProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$findPodcastHash();

  @$internal
  @override
  FindPodcast create() => FindPodcast();
}

String _$findPodcastHash() => r'7e531dc71823cfcf7588cf441af9a7510ac6f668';

abstract class _$FindPodcast extends $AsyncNotifier<List<PodcastSearch>> {
  FutureOr<List<PodcastSearch>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<PodcastSearch>>, List<PodcastSearch>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PodcastSearch>>, List<PodcastSearch>>,
              AsyncValue<List<PodcastSearch>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
