// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcasts_with_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PodcastsWithStatus)
const podcastsWithStatusProvider = PodcastsWithStatusProvider._();

final class PodcastsWithStatusProvider
    extends
        $AsyncNotifierProvider<
          PodcastsWithStatus,
          EquatableList<PodcastWithStatus>
        > {
  const PodcastsWithStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'podcastsWithStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$podcastsWithStatusHash();

  @$internal
  @override
  PodcastsWithStatus create() => PodcastsWithStatus();
}

String _$podcastsWithStatusHash() =>
    r'37782e6aa982d610883553f44f0cb29e4c741c66';

abstract class _$PodcastsWithStatus
    extends $AsyncNotifier<EquatableList<PodcastWithStatus>> {
  FutureOr<EquatableList<PodcastWithStatus>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EquatableList<PodcastWithStatus>>,
              EquatableList<PodcastWithStatus>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EquatableList<PodcastWithStatus>>,
                EquatableList<PodcastWithStatus>
              >,
              AsyncValue<EquatableList<PodcastWithStatus>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
