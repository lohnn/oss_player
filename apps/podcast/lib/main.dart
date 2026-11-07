import 'dart:async';
import 'dart:developer' as developer;

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:podcast/data/mappers/uri_mapper.dart';
import 'package:podcast/repository/repository_impl.dart';
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/navigation/podcase_router.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/screens/logged_in/logged_in_screen.dart';
import 'package:podcast_core/screens/logged_in/podcast_list_screen.dart';
import 'package:podcast_core/widgets/entry_animation_screen.dart';
import 'package:podcast_core/widgets/podcast_app.dart';
import 'package:rive_native/rive_native.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  await LocaleSettings.useDeviceLocale();

  if (kDebugMode) {
    hierarchicalLoggingEnabled = true;
    Logger.root.level = Level.OFF;
    Logger.root.onRecord.listen((record) {
      developer.log(
        record.message,
        time: record.time,
        level: record.level.value,
        name: record.loggerName,
        stackTrace: record.stackTrace,
        error: record.error,
        sequenceNumber: record.sequenceNumber,
        zone: record.zone,
      );
    });
  }

  MapperContainer.globals.use(const UriMapper());

  runApp(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => HiveRepositoryImpl()),
      ],
      child: const PodcastApp(child: _AppNavigation()),
    ),
  );
}

/// Creates the app-level router before the entry animation completes so the
/// router exists from process start and an engine-delivered deep link
/// (defaultRouteName) is captured on first frame, not after the animation.
class _AppNavigation extends StatefulWidget {
  const _AppNavigation();

  @override
  State<_AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<_AppNavigation> {
  late final GoRouter _router = createPodcaseRouter(
    homeBuilder: (_) => const PodcastListScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return EntryAnimationScreen(
      child: LoggedInScreen(router: _router),
    );
  }
}
