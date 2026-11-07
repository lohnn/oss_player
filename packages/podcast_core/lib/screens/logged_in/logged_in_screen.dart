import 'package:audio_service/audio_service.dart';
import 'package:custom_adaptive_scaffold/custom_adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_core/intents/play_pause_intent.dart';
import 'package:podcast_core/widgets/currently_playing_information.dart';
import 'package:podcast_core/widgets/podcast_actions.dart';
import 'package:podcast_core/widgets/small_media_player/small_media_player_controls.dart';

/// The logged-in app surface: hosts the app-level [router] for the
/// [AdaptiveLayout] body.
///
/// The router is created by the app shell (via `createPodcaseRouter`) so it
/// exists from process start and engine-native deep links survive the auth
/// gate; this screen only consumes it.
class LoggedInScreen extends StatelessWidget {
  final GoRouter router;

  const LoggedInScreen({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return PodcastActions(
      child: Shortcuts(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.mediaPlayPause):
              ChangePlayStateIntent(MediaAction.playPause),
          SingleActivator(LogicalKeyboardKey.mediaPlay): ChangePlayStateIntent(
            MediaAction.play,
          ),
          SingleActivator(LogicalKeyboardKey.mediaPause): ChangePlayStateIntent(
            MediaAction.pause,
          ),
          SingleActivator(LogicalKeyboardKey.mediaStop): ChangePlayStateIntent(
            MediaAction.pause,
          ),
        },
        child: AdaptiveLayout(
          bodyRatio: 0.7,
          bottomNavigation: SlotLayout(
            config: {
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('LoggedInScreen.SmallMediaPlayerControls'),
                builder: (context) => SmallMediaPlayerControls(router: router),
              ),
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('LoggedInScreen.SmallMediaPlayerControls'),
                builder: (context) => SmallMediaPlayerControls(
                  router: router,
                  showSkipButtons: true,
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: {
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('LoggedInScreen.Body'),
                builder: (context) => Router<Object>(
                  restorationScopeId: 'router',
                  routeInformationProvider: router.routeInformationProvider,
                  routeInformationParser: router.routeInformationParser,
                  routerDelegate: router.routerDelegate,
                  backButtonDispatcher: router.backButtonDispatcher,
                ),
              ),
            },
          ),
          secondaryBody: SlotLayout(
            config: {
              Breakpoints.mediumLargeAndUp: SlotLayout.from(
                key: const Key('LoggedInScreen.SecondaryBody'),
                builder: (context) =>
                    CurrentlyPlayingInformation(onNavigate: router.go),
              ),
            },
          ),
        ),
      ),
    );
  }
}
