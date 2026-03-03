import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';
import 'package:cineflow/features/movies/presentation/widgets/movie_grid.dart';
import 'package:cineflow/features/movies/presentation/widgets/movie_card.dart';

void main() {
  testWidgets('MovieGrid displays correct number of MovieCards', (
    WidgetTester tester,
  ) async {
    final testMovies = [
      Movie(
        id: 1,
        title: 'Movie 1',
        overview: 'Overview 1',
        voteAverage: 7.0,
        releaseDate: '2024-01-01',
      ),
      Movie(
        id: 2,
        title: 'Movie 2',
        overview: 'Overview 2',
        voteAverage: 8.0,
        releaseDate: '2024-01-02',
      ),
    ];

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(slivers: [MovieGrid(movies: testMovies)]),
          ),
        ),
      );

      // Verify the correct number of MovieCards are rendered
      expect(find.byType(MovieCard), findsNWidgets(2));

      // Verify specific movie titles are shown
      expect(find.text('Movie 1'), findsOneWidget);
      expect(find.text('Movie 2'), findsOneWidget);
    });
  });

  testWidgets('MovieGrid handles empty list correctly', (
    WidgetTester tester,
  ) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(slivers: [MovieGrid(movies: const [])]),
          ),
        ),
      );

      // Verify no MovieCards are rendered
      expect(find.byType(MovieCard), findsNothing);
    });
  });
}
