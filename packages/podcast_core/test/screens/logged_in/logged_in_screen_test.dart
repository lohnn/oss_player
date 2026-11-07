import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/data/podcast.model.dart' show PodcastId;
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/navigation/podcase_router.dart';
import 'package:podcast_core/screens/logged_in/logged_in_screen.dart';
import 'package:podcast_core/screens/logged_in/podcast_details_screen/podcast_details_screen.dart';

const _podcastSha =
    'a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2';
final _encPodcast = Uri.encodeComponent(_podcastSha);

/// A route's own content pushing the /p/ episode path — the in-app call-site
/// pattern (list items, player controls, currently-playing widget).
class _HomeWithLink extends StatelessWidget {
  const _HomeWithLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        key: const Key('home.podcast-link'),
        onPressed: () => context.push('/p/$_encPodcast'),
        child: const Text('open-podcast'),
      ),
    );
  }
}

void main() {
  testWidgets('LoggedInScreen renders the home route content provided by the '
      'router it is handed', (tester) async {
    final router = createPodcaseRouter(
      homeBuilder: (_) => const Text('home-marker'),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: TranslationProvider(
          child: MaterialApp(home: LoggedInScreen(router: router)),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('home-marker'), findsOneWidget);
  });

  testWidgets('in-app navigation inside LoggedInScreen routes through the '
      'router it was handed', (tester) async {
    final router = createPodcaseRouter(
      homeBuilder: (_) => const _HomeWithLink(),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: TranslationProvider(
          child: MaterialApp(home: LoggedInScreen(router: router)),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    await tester.tap(find.byKey(const Key('home.podcast-link')));
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(milliseconds: 16));

    // The embedded Router is the same instance: the push landed on the /p/
    // table with the decoded id. (routeInformationProvider only moves on
    // go-level navigations, so the delegate's matched location is probed.)
    expect(
      router.routerDelegate.currentConfiguration.last.matchedLocation,
      '/p/$_encPodcast',
    );
    final details = tester.widget<PodcastDetailsScreen>(
      find.byType(PodcastDetailsScreen),
    );
    expect(details.podcastId, PodcastId(_podcastSha));
  });
}
