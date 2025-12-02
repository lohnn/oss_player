// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_details_screen_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(podcastDetailsScreen)
const podcastDetailsScreenProvider = PodcastDetailsScreenFamily._();

final class PodcastDetailsScreenProvider
    extends
        $FunctionalProvider<
          AsyncValue<(Podcast, List<EpisodeWithStatus>)>,
          (Podcast, List<EpisodeWithStatus>),
          FutureOr<(Podcast, List<EpisodeWithStatus>)>
        >
    with
        $FutureModifier<(Podcast, List<EpisodeWithStatus>)>,
        $FutureProvider<(Podcast, List<EpisodeWithStatus>)> {
  const PodcastDetailsScreenProvider._({
    required PodcastDetailsScreenFamily super.from,
    required PodcastId super.argument,
  }) : super(
         retry: null,
         name: r'podcastDetailsScreenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$podcastDetailsScreenHash();

  @override
  String toString() {
    return r'podcastDetailsScreenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<(Podcast, List<EpisodeWithStatus>)> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<(Podcast, List<EpisodeWithStatus>)> create(Ref ref) {
    final argument = this.argument as PodcastId;
    return podcastDetailsScreen(ref, podcastId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PodcastDetailsScreenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$podcastDetailsScreenHash() =>
    r'26b1b8061bac54a962feea0081eb39f6e2555e7c';

final class PodcastDetailsScreenFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<(Podcast, List<EpisodeWithStatus>)>,
          PodcastId
        > {
  const PodcastDetailsScreenFamily._()
    : super(
        retry: null,
        name: r'podcastDetailsScreenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PodcastDetailsScreenProvider call({required PodcastId podcastId}) =>
      PodcastDetailsScreenProvider._(argument: podcastId, from: this);

  @override
  String toString() => r'podcastDetailsScreenProvider';
}
