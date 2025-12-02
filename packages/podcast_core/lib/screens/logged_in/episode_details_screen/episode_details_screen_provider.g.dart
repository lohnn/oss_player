// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_details_screen_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(episodeDetailsScreen)
const episodeDetailsScreenProvider = EpisodeDetailsScreenFamily._();

final class EpisodeDetailsScreenProvider
    extends
        $FunctionalProvider<
          AsyncValue<(Podcast, EpisodeWithStatus)>,
          (Podcast, EpisodeWithStatus),
          FutureOr<(Podcast, EpisodeWithStatus)>
        >
    with
        $FutureModifier<(Podcast, EpisodeWithStatus)>,
        $FutureProvider<(Podcast, EpisodeWithStatus)> {
  const EpisodeDetailsScreenProvider._({
    required EpisodeDetailsScreenFamily super.from,
    required ({PodcastId podcastId, EpisodeId episodeId}) super.argument,
  }) : super(
         retry: null,
         name: r'episodeDetailsScreenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$episodeDetailsScreenHash();

  @override
  String toString() {
    return r'episodeDetailsScreenProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<(Podcast, EpisodeWithStatus)> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<(Podcast, EpisodeWithStatus)> create(Ref ref) {
    final argument =
        this.argument as ({PodcastId podcastId, EpisodeId episodeId});
    return episodeDetailsScreen(
      ref,
      podcastId: argument.podcastId,
      episodeId: argument.episodeId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EpisodeDetailsScreenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$episodeDetailsScreenHash() =>
    r'7bac143c79530163b77ebe1b1ef3a06fc07b0f1f';

final class EpisodeDetailsScreenFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<(Podcast, EpisodeWithStatus)>,
          ({PodcastId podcastId, EpisodeId episodeId})
        > {
  const EpisodeDetailsScreenFamily._()
    : super(
        retry: null,
        name: r'episodeDetailsScreenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EpisodeDetailsScreenProvider call({
    required PodcastId podcastId,
    required EpisodeId episodeId,
  }) => EpisodeDetailsScreenProvider._(
    argument: (podcastId: podcastId, episodeId: episodeId),
    from: this,
  );

  @override
  String toString() => r'episodeDetailsScreenProvider';
}
