import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';
import 'package:cineflow/features/movies/presentation/widgets/featured_movie_header.dart';
import 'package:cineflow/core/theme/theme_toggle_button.dart';

void main() {
  testWidgets('FeaturedMovieHeader builds and displays correctly', (
    WidgetTester tester,
  ) async {
    final testMovie = Movie(
      id: 1,
      title: 'Featured Movie',
      overview: 'This is a featured movie overview that might be long.',
      backdropPath: '/featured_backdrop.jpg',
      voteAverage: 9.0,
      releaseDate: '2024-01-01',
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  FeaturedMovieHeader(movie: testMovie),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(title: Text('Item $index')),
                      childCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Verify the FEATURED badge is present
      expect(find.text('FEATURED'), findsOneWidget);

      // Verify title and overview are displayed
      expect(find.text('Featured Movie'), findsOneWidget);
      expect(
        find.text('This is a featured movie overview that might be long.'),
        findsOneWidget,
      );

      // Verify View Details button is present
      expect(find.text('View Details'), findsOneWidget);
    });
  });

  testWidgets('FeaturedMovieHeader triggers routing on View Details tap', (
    WidgetTester tester,
  ) async {
    final testMovie = Movie(
      id: 1,
      title: 'Featured Movie',
      overview: 'Overview text.',
      voteAverage: 9.0,
      releaseDate: '2024-01-01',
    );

    bool didRoute = false;

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: CustomScrollView(
              slivers: [FeaturedMovieHeader(movie: testMovie)],
            ),
          ),
        ),
        GoRoute(
          path: '/movie/:id',
          builder: (context, state) {
            didRoute = true;
            return const Scaffold(body: Text('Detail Screen'));
          },
        ),
      ],
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: router)),
      );

      // Tap the View Details button
      await tester.tap(find.text('View Details'));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(didRoute, isTrue);
      expect(find.text('Detail Screen'), findsOneWidget);
    });
  });

  testWidgets('FeaturedMovieHeader contains interactive app bar icons', (
    WidgetTester tester,
  ) async {
    final testMovie = Movie(
      id: 1,
      title: 'Featured Movie',
      overview: 'Overview.',
      voteAverage: 9.0,
      releaseDate: '2024-01-01',
    );

    bool didRouteToFavorites = false;
    bool didRouteToSearch = false;

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: CustomScrollView(
              slivers: [FeaturedMovieHeader(movie: testMovie)],
            ),
          ),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            didRouteToFavorites = true;
            return const Scaffold(body: Text('Favorites'));
          },
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) {
            didRouteToSearch = true;
            return const Scaffold(body: Text('Search'));
          },
        ),
      ],
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: router)),
      );

      // Verify icon presence
      expect(find.byType(ThemeToggleButton), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(FaIcon), findsOneWidget);

      // Tap Favorites
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();
      expect(didRouteToFavorites, isTrue);

      // Return to root to test another route
      router.go('/');
      await tester.pumpAndSettle();

      // Tap Search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(didRouteToSearch, isTrue);
    });
  });
}
