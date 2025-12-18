// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcasts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isSubscribedToRss)
const isSubscribedToRssProvider = IsSubscribedToRssFamily._();

final class IsSubscribedToRssProvider
    extends $FunctionalProvider<AsyncValue<bool?>, bool?, FutureOr<bool?>>
    with $FutureModifier<bool?>, $FutureProvider<bool?> {
  const IsSubscribedToRssProvider._({
    required IsSubscribedToRssFamily super.from,
    required PodcastRssUrl super.argument,
  }) : super(
         retry: null,
         name: r'isSubscribedToRssProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isSubscribedToRssHash();

  @override
  String toString() {
    return r'isSubscribedToRssProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool?> create(Ref ref) {
    final argument = this.argument as PodcastRssUrl;
    return isSubscribedToRss(ref, rssUrl: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IsSubscribedToRssProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isSubscribedToRssHash() => r'5149c1901eeae18c6c761212721892823de3a51d';

final class IsSubscribedToRssFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool?>, PodcastRssUrl> {
  const IsSubscribedToRssFamily._()
    : super(
        retry: null,
        name: r'isSubscribedToRssProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsSubscribedToRssProvider call({required PodcastRssUrl rssUrl}) =>
      IsSubscribedToRssProvider._(argument: rssUrl, from: this);

  @override
  String toString() => r'isSubscribedToRssProvider';
}
