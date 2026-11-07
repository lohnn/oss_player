import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/episode_with_status.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/data/podcast_with_status.dart';
import 'package:podcast_core/data/user_episode_status.model.dart';
import 'package:podcast_core/navigation/podcase_router.dart';
import 'package:podcast_core/providers/color_scheme_from_remote_image_provider.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/screens/logged_in/episode_details_screen/episode_details_screen.dart';
import 'package:podcast_core/screens/logged_in/episode_details_screen/episode_details_screen_provider.dart';
import 'package:podcast_core/screens/logged_in/podcast_details_screen/podcast_details_screen.dart';
import 'package:podcast_core/screens/logged_in/podcast_details_screen/podcast_details_screen_provider.dart';
import 'package:podcast_core/screens/logged_in/podcast_search_screen.dart';
import 'package:podcast_core/screens/logged_in/playlist_screen.dart';

import '../test_data_models/test_episode.dart';
import '../test_data_models/test_podcast.dart';

/// Realistic identifiers: a podcast id is the sha256 of the feed URL (64 hex
/// chars) and an episode id is `<podcastsha>:<guid>` where the guid may itself
/// be a URL.
const _podcastSha =
    'a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2';
const _guidUrl = 'https://feeds.example.com/guid/1';
final _encPodcast = Uri.encodeComponent(_podcastSha);
final _encGuid = Uri.encodeComponent(_guidUrl);

/// A controllable gate standing in for the app shell's auth state, wired to
/// the router through [refreshListenable] exactly like the closed app's user
/// stream bridge will be.
class TestGate extends ChangeNotifier {
  AuthGateState _state;

  TestGate(this._state);

  AuthGateState get state => _state;

  void update(AuthGateState next) {
    if (next == _state) return;
    _state = next;
    notifyListeners();
  }
}

class _RoutingTestRepository implements Repository {
  @override
  Stream<List<PodcastWithStatus>> watchPodcasts() => const Stream.empty();

  @override
  Future<void> updateLastSeenPodcast(PodcastId podcast) async {}

  @override
  Stream<List<UserEpisodeStatus>> watchUserEpisodeStatuses() =>
      const Stream.empty();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'Repository.${invocation.memberName} was not expected in this test',
    );
  }
}

class _Marker extends StatelessWidget {
  const _Marker(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(label));
  }
}

extension on WidgetTester {
  Future<void> pumpIdleFrames([int count = 3]) async {
    for (var i = 0; i < count; i++) {
      await pump(const Duration(milliseconds: 16));
    }
  }
}

Future<GoRouter> _pumpRouter(
  WidgetTester tester, {
  required WidgetBuilder homeBuilder,
  String? initialLocation,
  TestGate? gate,
  bool withLoginRoute = true,
  List<Override> overrides = const [],
}) async {
  final router = createPodcaseRouter(
    homeBuilder: homeBuilder,
    loginBuilder: withLoginRoute ? (_) => const _Marker('login-marker') : null,
    bootstrapBuilder: (_) => const _Marker('boot-marker'),
    forceUpgradeBuilder: (_) => const _Marker('upgrade-marker'),
    errorBuilder: (_) => const _Marker('error-marker'),
    refreshListenable: gate,
    authGateState: gate == null ? null : () => gate.state,
    initialLocation: initialLocation,
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpIdleFrames();
  return router;
}

void main() {
  group('auth-gate redirect triage', () {
    testWidgets('a boot gate holds a deep link at /boot without login flicker',
        (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.boot),
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('boot-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/boot?from=%2Fp%2F$_encPodcast%2F$_encGuid',
      );
    });

    testWidgets('a loading gate holds the root at /boot (no login flash)',
        (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loading),
      );

      expect(find.text('boot-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/boot?from=%2F',
      );
    });

    testWidgets('a loading gate holds a deep link at /boot', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loading),
        initialLocation: '/p/$_encPodcast',
      );

      expect(find.text('boot-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/boot?from=%2Fp%2F$_encPodcast',
      );
    });

    testWidgets('force upgrade outranks a deep link', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.forceUpgrade),
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('upgrade-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/upgrade',
      );
    });

    testWidgets('force upgrade outranks the login screen', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.forceUpgrade),
        initialLocation: '/login',
      );

      expect(find.text('upgrade-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.toString(), '/upgrade');
    });

    testWidgets('a logged out deep link lands on /login with the link in from',
        (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedOut),
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(find.text('boot-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/login?from=%2Fp%2F$_encPodcast%2F$_encGuid',
      );
    });

    testWidgets('a logged out root lands on /login', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedOut),
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/login?from=%2F',
      );
    });

    testWidgets('a logged out user already on /login stays there without a '
        'from redirect loop', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedOut),
        initialLocation: '/login',
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.toString(), '/login');
    });

    testWidgets('a logged in session on /login continues to the linked '
        'content', (tester) async {
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedIn),
        initialLocation: '/login?from=%2Fplaylist',
      );

      expect(find.byType(PlaylistScreen), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
    });

    testWidgets('a logged in user going to /login lands on home',
        (tester) async {
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedIn),
        initialLocation: '/login',
      );

      expect(find.text('home-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
    });
  });

  group('chained redirect', () {
    testWidgets('a boot-held deep link settles on the linked episode screen '
        'once the gate resolves to logged in', (tester) async {
      final gate = TestGate(AuthGateState.boot);
      final testPodcast = TestPodcast(
        id: PodcastId(_podcastSha),
        url: PodcastRssUrl.parse('http://example.com/feed.xml'),
        link: Uri.parse('http://example.com'),
        title: 'Decoded Podcast Title',
        description: 'Test Podcast Description',
        artwork: Uri.parse('http://example.com/podcast_image.png'),
      );
      final testEpisode = TestEpisode(
        id: EpisodeId(_guidUrl),
        url: Uri.parse('http://example.com/episode.mp3'),
        title: 'Decoded Episode Title',
        pubDate: DateTime(2024),
        description: 'Test Description',
        imageUrl: Uri.parse('http://example.com/episode_image.png'),
        podcastId: PodcastId(_podcastSha),
      );

      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/p/$_encPodcast/$_encGuid',
        overrides: [
          repositoryProvider.overrideWith((ref) => _RoutingTestRepository()),
          episodeDetailsScreenProvider(
            podcastId: PodcastId(_podcastSha),
            episodeId: EpisodeId(_guidUrl),
          ).overrideWith((_) => (testPodcast, testEpisode)),
          colorSchemeFromRemoteImageProvider(
            Uri.parse('http://example.com/episode_image.png'),
            Brightness.light,
          ).overrideWith(
            (ref) =>
                Future.value(ColorScheme.fromSeed(seedColor: Colors.blue)),
          ),
        ],
      );

      expect(find.text('boot-marker'), findsOneWidget);

      gate.update(AuthGateState.loggedIn);
      await tester.pumpIdleFrames();

      expect(find.text('home-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/p/$_encPodcast/$_encGuid',
      );
      // The screen rendered the episode whose ids round-tripped through the
      // /boot from= query — i.e. the chained redirect re-resolved after the
      // gate opened (the go_router 17.2.1 fix we bumped for).
      expect(find.text('Decoded Episode Title'), findsOneWidget);
    });

    testWidgets('a boot-held deep link that resolves logged out continues to '
        '/login with the original link as from', (tester) async {
      final gate = TestGate(AuthGateState.boot);
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('boot-marker'), findsOneWidget);

      gate.update(AuthGateState.loggedOut);
      await tester.pumpIdleFrames();

      expect(find.text('login-marker'), findsOneWidget);
      // Single-encoded: the original link, not the /boot from= metadata.
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/login?from=%2Fp%2F$_encPodcast%2F$_encGuid',
      );
    });

    testWidgets('a session that resolves into force upgrade lands on the '
        'upgrade screen', (tester) async {
      final gate = TestGate(AuthGateState.boot);
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/p/$_encPodcast',
      );

      gate.update(AuthGateState.forceUpgrade);
      await tester.pumpIdleFrames();

      expect(find.text('upgrade-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.toString(), '/upgrade');
    });

    testWidgets('a logged out search link keeps its query through login and '
        'lands back on search', (tester) async {
      final gate = TestGate(AuthGateState.loggedOut);
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/s?q=deep%20link',
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/login?from=%2Fs%3Fq%3Ddeep%2520link',
      );

      gate.update(AuthGateState.loggedIn);
      await tester.pumpIdleFrames();

      expect(find.byType(PodcastSearchScreen), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.queryParameters['q'],
          'deep link');
    });
  });

  group('/p/ route table', () {
    testWidgets('a podcast deep link lands on podcast details with the '
        'decoded id', (tester) async {
      final testPodcast = TestPodcast(
        id: PodcastId(_podcastSha),
        url: PodcastRssUrl.parse('http://example.com/feed.xml'),
        link: Uri.parse('http://example.com'),
        title: 'Decoded Podcast Title',
        description: 'Test Podcast Description',
        artwork: Uri.parse('http://example.com/podcast_image.png'),
      );

      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        initialLocation: '/p/$_encPodcast',
        overrides: [
          repositoryProvider.overrideWith((ref) => _RoutingTestRepository()),
          podcastDetailsScreenProvider(
            podcastId: PodcastId(_podcastSha),
          ).overrideWith((_) => (testPodcast, <EpisodeWithStatus>[])),
        ],
      );

      expect(find.byType(PodcastDetailsScreen), findsOneWidget);
      // The title text can only render if the provider override keyed on the
      // DECODED id matched the path parameter.
      expect(find.text('Decoded Podcast Title'), findsOneWidget);
    });

    testWidgets('route paths that match nothing render the error surface',
        (tester) async {
      // The legacy unscoped shapes exist nowhere in the wild, so the migration
      // intentionally drops them (design decision 2026-11-07).
      final unmatched = [
        '/p',
        '/p/',
        '/p/$_encPodcast/$_encGuid/extra-segment',
        '/no-such-path',
        '/$_encPodcast/$_encGuid',
      ];

      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        initialLocation: unmatched.first,
      );

      for (final location in unmatched) {
        router.go(location);
        await tester.pumpIdleFrames();

        expect(find.text('error-marker'), findsOneWidget,
            reason: 'location "$location" should use the error builder');
      }
    });

    testWidgets('the primary routes keep their screens', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
      );

      expect(find.text('home-marker'), findsOneWidget);

      router.go('/s?q=hello');
      await tester.pumpIdleFrames();
      expect(find.byType(PodcastSearchScreen), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.queryParameters['q'],
          'hello');

      router.go('/playlist');
      await tester.pumpIdleFrames();
      expect(find.byType(PlaylistScreen), findsOneWidget);
    });
  });

  group('OSS mode (no gate)', () {
    testWidgets('deep links stay always open without /boot or redirects',
        (tester) async {
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        withLoginRoute: false,
        initialLocation: '/playlist',
      );

      expect(find.byType(PlaylistScreen), findsOneWidget);
      expect(find.text('boot-marker'), findsNothing);
      expect(find.text('login-marker'), findsNothing);
    });

    testWidgets('an unknown /login location uses the error builder (no login '
        'route exists)', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        withLoginRoute: false,
      );

      router.go('/login');
      await tester.pumpIdleFrames();

      expect(find.text('error-marker'), findsOneWidget);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/login',
      );
    });
  });

  group('root exit policy', () {
    testWidgets('the root exit dialog is shown and a confirmation veto keeps '
        'the app open', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        withLoginRoute: false,
      );

      final popped = await tester.binding.handlePopRoute();
      await tester.pumpIdleFrames();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(popped, isFalse);

      // The "No" action must cancel the route removal entirely.
      final noButton = find.ancestor(
        of: find.byType(AlertDialog),
        matching: find.byType(TextButton),
      ).first;
      await tester.tap(noButton);
      await tester.pumpIdleFrames();

      expect(find.text('home-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.path, '/');
    });

    testWidgets('a gate redirect away from home does not show the exit dialog',
        (tester) async {
      final gate = TestGate(AuthGateState.loggedIn);
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
      );

      expect(find.text('home-marker'), findsOneWidget);

      gate.update(AuthGateState.loggedOut);
      await tester.pumpIdleFrames();

      expect(find.text('login-marker'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
