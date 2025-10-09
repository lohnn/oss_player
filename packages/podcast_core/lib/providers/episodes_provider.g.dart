// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(episode)
const episodeProvider = EpisodeFamily._();

final class EpisodeProvider
    extends $FunctionalProvider<AsyncValue<Episode>, Episode, FutureOr<Episode>>
    with $FutureModifier<Episode>, $FutureProvider<Episode> {
  const EpisodeProvider._({
    required EpisodeFamily super.from,
    required EpisodeId super.argument,
  }) : super(
         retry: null,
         name: r'episodeProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$episodeHash();

  @override
  String toString() {
    return r'episodeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Episode> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Episode> create(Ref ref) {
    final argument = this.argument as EpisodeId;
    return episode(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EpisodeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$episodeHash() => r'aa712a9e50098698143a8157a860948f8a40645a';

final class EpisodeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Episode>, EpisodeId> {
  const EpisodeFamily._()
    : super(
        retry: null,
        name: r'episodeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  EpisodeProvider call(EpisodeId episodeId) =>
      EpisodeProvider._(argument: episodeId, from: this);

  @override
  String toString() => r'episodeProvider';
}

@ProviderFor(PodcastAndEpisodePod)
const podcastAndEpisodePodProvider = PodcastAndEpisodePodFamily._();

final class PodcastAndEpisodePodProvider
    extends
        $NotifierProvider<
          PodcastAndEpisodePod,
          AsyncValue<(Podcast, EpisodeWithStatus)>
        > {
  const PodcastAndEpisodePodProvider._({
    required PodcastAndEpisodePodFamily super.from,
    required ({PodcastId podcastId, EpisodeId episodeId}) super.argument,
  }) : super(
         retry: null,
         name: r'podcastAndEpisodePodProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$podcastAndEpisodePodHash();

  @override
  String toString() {
    return r'podcastAndEpisodePodProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PodcastAndEpisodePod create() => PodcastAndEpisodePod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<(Podcast, EpisodeWithStatus)> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<(Podcast, EpisodeWithStatus)>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PodcastAndEpisodePodProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$podcastAndEpisodePodHash() =>
    r'19661ca894ad15616f54e949b822590f07c7a888';

final class PodcastAndEpisodePodFamily extends $Family
    with
        $ClassFamilyOverride<
          PodcastAndEpisodePod,
          AsyncValue<(Podcast, EpisodeWithStatus)>,
          AsyncValue<(Podcast, EpisodeWithStatus)>,
          AsyncValue<(Podcast, EpisodeWithStatus)>,
          ({PodcastId podcastId, EpisodeId episodeId})
        > {
  const PodcastAndEpisodePodFamily._()
    : super(
        retry: null,
        name: r'podcastAndEpisodePodProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PodcastAndEpisodePodProvider call({
    required PodcastId podcastId,
    required EpisodeId episodeId,
  }) => PodcastAndEpisodePodProvider._(
    argument: (podcastId: podcastId, episodeId: episodeId),
    from: this,
  );

  @override
  String toString() => r'podcastAndEpisodePodProvider';
}

abstract class _$PodcastAndEpisodePod
    extends $Notifier<AsyncValue<(Podcast, EpisodeWithStatus)>> {
  late final _$args = ref.$arg as ({PodcastId podcastId, EpisodeId episodeId});
  PodcastId get podcastId => _$args.podcastId;
  EpisodeId get episodeId => _$args.episodeId;

  AsyncValue<(Podcast, EpisodeWithStatus)> build({
    required PodcastId podcastId,
    required EpisodeId episodeId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      podcastId: _$args.podcastId,
      episodeId: _$args.episodeId,
    );
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(Podcast, EpisodeWithStatus)>,
              AsyncValue<(Podcast, EpisodeWithStatus)>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(Podcast, EpisodeWithStatus)>,
                AsyncValue<(Podcast, EpisodeWithStatus)>
              >,
              AsyncValue<(Podcast, EpisodeWithStatus)>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(PodcastAndEpisodes)
const podcastAndEpisodesProvider = PodcastAndEpisodesFamily._();

final class PodcastAndEpisodesProvider
    extends
        $NotifierProvider<
          PodcastAndEpisodes,
          AsyncValue<(Podcast, List<EpisodeWithStatus>)>
        > {
  const PodcastAndEpisodesProvider._({
    required PodcastAndEpisodesFamily super.from,
    required PodcastId super.argument,
  }) : super(
         retry: null,
         name: r'podcastAndEpisodesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$podcastAndEpisodesHash();

  @override
  String toString() {
    return r'podcastAndEpisodesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PodcastAndEpisodes create() => PodcastAndEpisodes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    AsyncValue<(Podcast, List<EpisodeWithStatus>)> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<(Podcast, List<EpisodeWithStatus>)>>(
            value,
          ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PodcastAndEpisodesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$podcastAndEpisodesHash() =>
    r'36d24a96d77ab550194b060719e7f4ce01f23b29';

final class PodcastAndEpisodesFamily extends $Family
    with
        $ClassFamilyOverride<
          PodcastAndEpisodes,
          AsyncValue<(Podcast, List<EpisodeWithStatus>)>,
          AsyncValue<(Podcast, List<EpisodeWithStatus>)>,
          AsyncValue<(Podcast, List<EpisodeWithStatus>)>,
          PodcastId
        > {
  const PodcastAndEpisodesFamily._()
    : super(
        retry: null,
        name: r'podcastAndEpisodesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PodcastAndEpisodesProvider call({required PodcastId podcastId}) =>
      PodcastAndEpisodesProvider._(argument: podcastId, from: this);

  @override
  String toString() => r'podcastAndEpisodesProvider';
}

abstract class _$PodcastAndEpisodes
    extends $Notifier<AsyncValue<(Podcast, List<EpisodeWithStatus>)>> {
  late final _$args = ref.$arg as PodcastId;
  PodcastId get podcastId => _$args;

  AsyncValue<(Podcast, List<EpisodeWithStatus>)> build({
    required PodcastId podcastId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(podcastId: _$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(Podcast, List<EpisodeWithStatus>)>,
              AsyncValue<(Podcast, List<EpisodeWithStatus>)>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(Podcast, List<EpisodeWithStatus>)>,
                AsyncValue<(Podcast, List<EpisodeWithStatus>)>
              >,
              AsyncValue<(Podcast, List<EpisodeWithStatus>)>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_episodesImpl)
const _episodesImplProvider = _EpisodesImplFamily._();

final class _EpisodesImplProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Episode>>,
          List<Episode>,
          Stream<List<Episode>>
        >
    with $FutureModifier<List<Episode>>, $StreamProvider<List<Episode>> {
  const _EpisodesImplProvider._({
    required _EpisodesImplFamily super.from,
    required PodcastId super.argument,
  }) : super(
         retry: null,
         name: r'_episodesImplProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_episodesImplHash();

  @override
  String toString() {
    return r'_episodesImplProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Episode>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Episode>> create(Ref ref) {
    final argument = this.argument as PodcastId;
    return _episodesImpl(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _EpisodesImplProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$_episodesImplHash() => r'794fb9c0d958f47936dfeaa20d64f2a77cd87d5a';

final class _EpisodesImplFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Episode>>, PodcastId> {
  const _EpisodesImplFamily._()
    : super(
        retry: null,
        name: r'_episodesImplProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _EpisodesImplProvider call(PodcastId podcast) =>
      _EpisodesImplProvider._(argument: podcast, from: this);

  @override
  String toString() => r'_episodesImplProvider';
}
