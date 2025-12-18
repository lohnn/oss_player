// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_color_scheme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentPlayingEpisodeColorScheme)
const currentPlayingEpisodeColorSchemeProvider =
    CurrentPlayingEpisodeColorSchemeFamily._();

final class CurrentPlayingEpisodeColorSchemeProvider
    extends
        $FunctionalProvider<
          AsyncValue<ColorScheme?>,
          ColorScheme?,
          FutureOr<ColorScheme?>
        >
    with $FutureModifier<ColorScheme?>, $FutureProvider<ColorScheme?> {
  const CurrentPlayingEpisodeColorSchemeProvider._({
    required CurrentPlayingEpisodeColorSchemeFamily super.from,
    required Brightness super.argument,
  }) : super(
         retry: null,
         name: r'currentPlayingEpisodeColorSchemeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentPlayingEpisodeColorSchemeHash();

  @override
  String toString() {
    return r'currentPlayingEpisodeColorSchemeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ColorScheme?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ColorScheme?> create(Ref ref) {
    final argument = this.argument as Brightness;
    return currentPlayingEpisodeColorScheme(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentPlayingEpisodeColorSchemeProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentPlayingEpisodeColorSchemeHash() =>
    r'dc5c91c3a0cbb1fa4437540c66ede22f526bbfb3';

final class CurrentPlayingEpisodeColorSchemeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ColorScheme?>, Brightness> {
  const CurrentPlayingEpisodeColorSchemeFamily._()
    : super(
        retry: null,
        name: r'currentPlayingEpisodeColorSchemeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentPlayingEpisodeColorSchemeProvider call(Brightness brightness) =>
      CurrentPlayingEpisodeColorSchemeProvider._(
        argument: brightness,
        from: this,
      );

  @override
  String toString() => r'currentPlayingEpisodeColorSchemeProvider';
}
