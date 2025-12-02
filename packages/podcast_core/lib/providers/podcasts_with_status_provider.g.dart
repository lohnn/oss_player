// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcasts_with_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(podcastWithStatus)
const podcastWithStatusProvider = PodcastWithStatusFamily._();

final class PodcastWithStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<PodcastWithStatus?>,
          PodcastWithStatus?,
          FutureOr<PodcastWithStatus?>
        >
    with
        $FutureModifier<PodcastWithStatus?>,
        $FutureProvider<PodcastWithStatus?> {
  const PodcastWithStatusProvider._({
    required PodcastWithStatusFamily super.from,
    required PodcastId super.argument,
  }) : super(
         retry: null,
         name: r'podcastWithStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$podcastWithStatusHash();

  @override
  String toString() {
    return r'podcastWithStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PodcastWithStatus?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PodcastWithStatus?> create(Ref ref) {
    final argument = this.argument as PodcastId;
    return podcastWithStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PodcastWithStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$podcastWithStatusHash() => r'8cb1a2da6321ded110b0365cd2a8110f95333220';

final class PodcastWithStatusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PodcastWithStatus?>, PodcastId> {
  const PodcastWithStatusFamily._()
    : super(
        retry: null,
        name: r'podcastWithStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PodcastWithStatusProvider call(PodcastId podcastId) =>
      PodcastWithStatusProvider._(argument: podcastId, from: this);

  @override
  String toString() => r'podcastWithStatusProvider';
}

@ProviderFor(PodcastsWithStatus)
const podcastsWithStatusProvider = PodcastsWithStatusProvider._();

final class PodcastsWithStatusProvider
    extends
        $StreamNotifierProvider<
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
    r'c55038fe04889587edd82fb7c1d9cabfd46ba772';

abstract class _$PodcastsWithStatus
    extends $StreamNotifier<EquatableList<PodcastWithStatus>> {
  Stream<EquatableList<PodcastWithStatus>> build();
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
