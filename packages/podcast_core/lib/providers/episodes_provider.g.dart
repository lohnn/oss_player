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

@ProviderFor(EpisodesWithStatusForPodcast)
const episodesWithStatusForPodcastProvider =
    EpisodesWithStatusForPodcastFamily._();

final class EpisodesWithStatusForPodcastProvider
    extends
        $AsyncNotifierProvider<
          EpisodesWithStatusForPodcast,
          List<EpisodeWithStatus>
        > {
  const EpisodesWithStatusForPodcastProvider._({
    required EpisodesWithStatusForPodcastFamily super.from,
    required PodcastId super.argument,
  }) : super(
         retry: null,
         name: r'episodesWithStatusForPodcastProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$episodesWithStatusForPodcastHash();

  @override
  String toString() {
    return r'episodesWithStatusForPodcastProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EpisodesWithStatusForPodcast create() => EpisodesWithStatusForPodcast();

  @override
  bool operator ==(Object other) {
    return other is EpisodesWithStatusForPodcastProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$episodesWithStatusForPodcastHash() =>
    r'6cbad76398c9ce926980529505d3a5dc715a441b';

final class EpisodesWithStatusForPodcastFamily extends $Family
    with
        $ClassFamilyOverride<
          EpisodesWithStatusForPodcast,
          AsyncValue<List<EpisodeWithStatus>>,
          List<EpisodeWithStatus>,
          FutureOr<List<EpisodeWithStatus>>,
          PodcastId
        > {
  const EpisodesWithStatusForPodcastFamily._()
    : super(
        retry: null,
        name: r'episodesWithStatusForPodcastProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EpisodesWithStatusForPodcastProvider call({required PodcastId podcastId}) =>
      EpisodesWithStatusForPodcastProvider._(argument: podcastId, from: this);

  @override
  String toString() => r'episodesWithStatusForPodcastProvider';
}

abstract class _$EpisodesWithStatusForPodcast
    extends $AsyncNotifier<List<EpisodeWithStatus>> {
  late final _$args = ref.$arg as PodcastId;
  PodcastId get podcastId => _$args;

  FutureOr<List<EpisodeWithStatus>> build({required PodcastId podcastId});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(podcastId: _$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<EpisodeWithStatus>>,
              List<EpisodeWithStatus>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EpisodeWithStatus>>,
                List<EpisodeWithStatus>
              >,
              AsyncValue<List<EpisodeWithStatus>>,
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
