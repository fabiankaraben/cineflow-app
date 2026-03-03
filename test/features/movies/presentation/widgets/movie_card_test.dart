import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:go_router/go_router.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';
import 'package:cineflow/features/movies/presentation/widgets/movie_card.dart';

void main() {
  testWidgets('MovieCard builds correctly and displays movie details', (
    WidgetTester tester,
  ) async {
    final testMovie = Movie(
      id: 123,
      title: 'Inception',
      overview: 'A mind-bending thriller.',
      posterPath: '/inception_poster.jpg',
      backdropPath: '/inception_backdrop.jpg',
      voteAverage: 8.8,
      releaseDate: '2010-07-16',
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 300,
                child: MovieCard(movie: testMovie),
              ),
            ),
          ),
        ),
      );

      // Verify widget displays the movie title
      expect(find.text('Inception'), findsOneWidget);

      // Verify widget displays the vote average formatted correctly
      expect(find.text('8.8'), findsOneWidget);

      // Verify the star icon is shown
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  testWidgets('MovieCard triggers routing on tap', (WidgetTester tester) async {
    final testMovie = Movie(
      id: 123,
      title: 'Inception',
      overview: 'A mind-bending thriller.',
      voteAverage: 8.8,
      releaseDate: '2010-07-16',
    );

    bool didRoute = false;

    // A simple mock router to verify navigation
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 300,
                child: MovieCard(movie: testMovie),
              ),
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
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Tap the movie card
      await tester.tap(find.byType(MovieCard));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(didRoute, isTrue);
      expect(find.text('Detail Screen'), findsOneWidget);
    });
  });
}
