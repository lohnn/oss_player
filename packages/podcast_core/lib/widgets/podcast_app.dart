import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/providers/episode_color_scheme_provider.dart';

class PodcastApp extends StatefulHookConsumerWidget {
  final Widget child;

  const PodcastApp({super.key, required this.child});

  @override
  ConsumerState<PodcastApp> createState() => _PodcastAppState();
}

class _PodcastAppState extends ConsumerState<PodcastApp> {
  Future<ColorScheme> _loadDefaultColorScheme(Brightness brightness) async {
    const icon = AssetImage(
      'assets/icons/app_icon.webp',
      package: 'podcast_core',
    );
    return await ColorScheme.fromImageProvider(
      provider: icon,
      brightness: brightness,
    );
  }

  @override
  void initState() {
    super.initState();
    LocaleSettings.useDeviceLocale();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final iconColorSchemeFuture = useMemoized(() {
      return _loadDefaultColorScheme(brightness);
    }, [brightness]);
    final iconColorScheme = useFuture(iconColorSchemeFuture).data;

    final colorScheme = ref
        .watch(currentPlayingEpisodeColorSchemeProvider(brightness))
        .value;

    if (colorScheme ?? iconColorScheme case final colorScheme?) {
      return TranslationProvider(
        child: Builder(
          builder: (context) {
            return MaterialApp(
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              theme: ThemeData.light().applyPodcastTheme(colorScheme),
              darkTheme: ThemeData.dark().applyPodcastTheme(colorScheme),
              debugShowCheckedModeBanner: false,
              builder: kDebugMode
                  ? (_, child) => AccessibilityTools(
                      logLevel: LogLevel.none,
                      buttonsAlignment: ButtonsAlignment.bottomLeft,
                      child: child,
                    )
                  : null,
              home: widget.child,
            );
          },
        ),
      );
    }

    // If the color scheme is not loaded yet, return an empty container
    return Container();
  }
}

extension on ThemeData {
  ThemeData applyPodcastTheme(ColorScheme colorScheme) {
    return copyWith(
      splashFactory: InkSparkle.splashFactory,
      colorScheme: colorScheme,
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size.zero),
          padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        ),
      ),
    );
  }
}
