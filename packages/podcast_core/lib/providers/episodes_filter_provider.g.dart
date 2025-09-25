// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodes_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EpisodesFilter)
const episodesFilterProvider = EpisodesFilterProvider._();

final class EpisodesFilterProvider
    extends $NotifierProvider<EpisodesFilter, EpisodesFilterState> {
  const EpisodesFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'episodesFilterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$episodesFilterHash();

  @$internal
  @override
  EpisodesFilter create() => EpisodesFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EpisodesFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EpisodesFilterState>(value),
    );
  }
}

String _$episodesFilterHash() => r'65e59f9a63535544fe63bbe5d51b1f06feaeb9e4';

abstract class _$EpisodesFilter extends $Notifier<EpisodesFilterState> {
  EpisodesFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EpisodesFilterState, EpisodesFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EpisodesFilterState, EpisodesFilterState>,
              EpisodesFilterState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
