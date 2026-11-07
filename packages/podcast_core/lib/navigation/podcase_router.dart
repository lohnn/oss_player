import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/providers/app_lifecycle_state_provider.dart';
import 'package:podcast_core/providers/audio_player_provider.dart';
import 'package:podcast_core/screens/logged_in/episode_details_screen/episode_details_screen.dart';
import 'package:podcast_core/screens/logged_in/playlist_screen.dart';
import 'package:podcast_core/screens/logged_in/podcast_details_screen/podcast_details_screen.dart';
import 'package:podcast_core/screens/logged_in/podcast_search_screen.dart';

/// The auth triage the router's redirect callback performs.
///
/// The shell owning auth (e.g. the login-gated app) maps its user stream onto
/// this state and hands both the reader and a [Listenable] to
/// [createPodcaseRouter]; a `null` gate (the open-source app) means the gate
/// is always open and no auth routes exist.
enum AuthGateState {
  /// The app figures out whether a session exists; no UI decisions yet.
  boot,

  /// A session exists but is being verified.
  loading,

  /// The session is fine but the app version is too old to run.
  forceUpgrade,

  /// No session (or the session ended).
  loggedOut,

  /// A usable session.
  loggedIn,
}

/// Reads the current [AuthGateState] synchronously — the redirect callback is
/// synchronous, so the shell must be able to answer without awaiting.
typedef AuthGateStateReader = AuthGateState Function();

const _loginPath = '/login';
const _bootPath = '/boot';
const _upgradePath = '/upgrade';

/// The location for a podcast's details screen — internal navigation and
/// external deep links share this exact URL space.
String podcastDetailsPath(PodcastId podcastId) => '/p/${podcastId.safe}';

/// The location for an episode's details screen.
String episodeDetailsPath(PodcastId podcastId, EpisodeId episodeId) =>
    '/p/${podcastId.safe}/${episodeId.safe}';

/// Builds the app-level router.
///
/// The router must exist from process start so engine-native deep links
/// (`defaultRouteName` / `didPushRouteInformation`) survive the auth gate
/// without any link stash: the redirect is the only policy needed.
///
/// The route table mirrors the public URL space:
/// `/` (podcast list), `/p/:podcastId`, `/p/:podcastId/:episodeId`,
/// `/s`, `/playlist` — plus, in gated mode, `/login`, `/boot` and `/upgrade`.
///
/// The [homeBuilder] indirection keeps app-specific list screens injectable
/// (the open-source app's default list screen vs an ad-supported one); the
/// login/bootstrap/force-upgrade surfaces are shell-owned and become routes
/// only when their builder is provided.
///
/// The close-app confirm dialog on the root route runs only when the gate
/// reports [AuthGateState.loggedIn]: redirect removals (a boot hold, a login
/// bounce, a forced upgrade) are navigation, not a user intent to leave.
GoRouter createPodcaseRouter({
  required WidgetBuilder homeBuilder,
  WidgetBuilder? loginBuilder,
  WidgetBuilder? bootstrapBuilder,
  WidgetBuilder? forceUpgradeBuilder,
  WidgetBuilder? errorBuilder,
  Listenable? refreshListenable,
  AuthGateStateReader? authGateState,
  NavigatorObserver? navigatorObserver,

  /// Where the router starts. The engine's cold-start deep link
  /// (`platformDispatcher.defaultRouteName`) overrides this at runtime
  /// automatically; the parameter exists for composition and tests.
  String? initialLocation,
}) {
  if (authGateState != null && loginBuilder == null) {
    throw ArgumentError.value(
      loginBuilder,
      'loginBuilder',
      'is required when authGateState is provided',
    );
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final gate = authGateState?.call();
    if (gate == null) return null;

    final uri = state.uri;
    final target = uri.path;

    // 1. Force upgrade outranks everything, including an in-flight login.
    if (gate == AuthGateState.forceUpgrade) {
      return forceUpgradeBuilder == null || target == _upgradePath
          ? null
          : _upgradePath;
    }

    // 2. While booting/loading, hold at /boot — never flash the login UI.
    //    The intended destination travels in from= so it survives the hold.
    if (gate == AuthGateState.boot || gate == AuthGateState.loading) {
      if (bootstrapBuilder == null || target == _bootPath) return null;
      return '$_bootPath?from=${Uri.encodeQueryComponent(uri.toString())}';
    }

    // 3. The boot phase is over: continue to the originally requested
    //    location. The redirect chain re-runs from there.
    if (target == _bootPath) {
      final from = uri.queryParameters['from'];
      return from == null || from.isEmpty ? '/' : from;
    }

    // 4. A logged out user can only be at /login; the link they wanted is
    //    parked in from= until the session returns.
    if (gate == AuthGateState.loggedOut) {
      return target == _loginPath
          ? null
          : '$_loginPath?from=${Uri.encodeQueryComponent(uri.toString())}';
    }

    // 5. A logged in user landing on /login continues to where the link
    //    pointed, or home.
    if (gate == AuthGateState.loggedIn && target == _loginPath) {
      final from = uri.queryParameters['from'];
      return from == null || from.isEmpty ? '/' : from;
    }

    return null;
  }

  return GoRouter(
    observers: [?navigatorObserver],
    initialLocation: initialLocation,
    refreshListenable: refreshListenable,
    redirect: redirect,
    errorBuilder: errorBuilder == null
        ? null
        : (context, state) => errorBuilder(context),
    routes: [
      if (loginBuilder != null)
        GoRoute(
          path: _loginPath,
          builder: (context, state) => loginBuilder(context),
        ),
      if (bootstrapBuilder != null)
        GoRoute(
          path: _bootPath,
          builder: (context, state) => bootstrapBuilder(context),
        ),
      if (forceUpgradeBuilder != null)
        GoRoute(
          path: _upgradePath,
          builder: (context, state) => forceUpgradeBuilder(context),
        ),
      GoRoute(
        path: '/',
        onExit: (context, _) async {
          // A gate redirect moving the session (to /boot, /login or
          // /upgrade) is not the user trying to leave the app.
          final gate = authGateState?.call();
          if (gate != null && gate != AuthGateState.loggedIn) return true;

          // The container must be resolved before the dialog's async gap.
          final container = ProviderScope.containerOf(context, listen: false);

          final shouldClose = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(context.t.exitDialog.title),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(context.t.exitDialog.no),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(context.t.exitDialog.yes),
                  ),
                ],
              );
            },
          );

          if (!(shouldClose ?? false)) return false;

          // Kill the app if the user tries to pop the main screen
          // Stopping the audio player
          await container.read(audioPlayerPodProvider.notifier).dispose();
          // Stopping all sockets
          container.read(appLifecycleStatePodProvider.notifier).close();
          // Closing the app
          await SystemNavigator.pop();
          return false;
        },
        builder: (context, state) => homeBuilder(context),
        routes: [
          GoRoute(
            path: '/s',
            builder: (context, state) => PodcastSearchScreen(
              initialQuery: state.uri.queryParameters['q'],
            ),
          ),
          GoRoute(
            path: '/playlist',
            builder: (context, state) => const PlaylistScreen(),
          ),
          GoRoute(
            path: '/p/:podcastId',
            builder: (context, state) => PodcastDetailsScreen(
              PodcastId.fromPathParameter(state.pathParameters['podcastId']!),
            ),
            routes: [
              GoRoute(
                path: '/:episodeId',
                builder: (context, state) => EpisodeDetailsScreen(
                  podcastId: PodcastId.fromPathParameter(
                    state.pathParameters['podcastId']!,
                  ),
                  episodeId: EpisodeId.fromPathParameter(
                    state.pathParameters['episodeId']!,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
