import 'package:flutter_test/flutter_test.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';

void main() {
  group('Movie Entity Unit Tests', () {
    final tMovie = Movie(
      id: 1,
      title: 'Test Movie',
      overview: 'Test Overview',
      posterPath: '/poster.jpg',
      backdropPath: '/backdrop.jpg',
      voteAverage: 8.5,
      releaseDate: '2024-01-01',
    );

    test(
      'should correctly return fullPosterPath when posterPath is provided',
      () {
        expect(
          tMovie.fullPosterPath,
          'https://image.tmdb.org/t/p/w500/poster.jpg',
        );
      },
    );

    test(
      'should correctly return fullPosterPath when posterPath is an http URL',
      () {
        final movieWithHttp = Movie(
          id: 1,
          title: 'Test Movie',
          overview: 'Test Overview',
          posterPath: 'http://example.com/poster.jpg',
          voteAverage: 8.5,
          releaseDate: '2024-01-01',
        );
        expect(movieWithHttp.fullPosterPath, 'http://example.com/poster.jpg');
      },
    );

    test('should return placeholder poster path when posterPath is null', () {
      final movieNullPoster = Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        voteAverage: 8.5,
        releaseDate: '2024-01-01',
      );
      expect(
        movieNullPoster.fullPosterPath,
        'https://via.placeholder.com/500x750?text=No+Image',
      );
    });

    test(
      'should correctly return fullBackdropPath when backdropPath is provided',
      () {
        expect(
          tMovie.fullBackdropPath,
          'https://image.tmdb.org/t/p/original/backdrop.jpg',
        );
      },
    );

    test(
      'should correctly return fullBackdropPath when backdropPath is an http URL',
      () {
        final movieWithHttp = Movie(
          id: 1,
          title: 'Test Movie',
          overview: 'Test Overview',
          backdropPath: 'http://example.com/backdrop.jpg',
          voteAverage: 8.5,
          releaseDate: '2024-01-01',
        );
        expect(
          movieWithHttp.fullBackdropPath,
          'http://example.com/backdrop.jpg',
        );
      },
    );

    test(
      'should return placeholder backdrop path when backdropPath is null',
      () {
        final movieNullBackdrop = Movie(
          id: 1,
          title: 'Test Movie',
          overview: 'Test Overview',
          voteAverage: 8.5,
          releaseDate: '2024-01-01',
        );
        expect(
          movieNullBackdrop.fullBackdropPath,
          'https://via.placeholder.com/1920x1080?text=No+Image',
        );
      },
    );

    test('toJson should return a valid Map containing the proper data', () {
      final result = tMovie.toJson();
      final expectedMap = {
        'id': 1,
        'title': 'Test Movie',
        'overview': 'Test Overview',
        'poster_path': '/poster.jpg',
        'backdrop_path': '/backdrop.jpg',
        'vote_average': 8.5,
        'release_date': '2024-01-01',
      };
      expect(result, expectedMap);
    });

    test('fromJson should return a valid model when JSON is provided', () {
      final jsonMap = {
        'id': 1,
        'title': 'Test Movie',
        'overview': 'Test Overview',
        'poster_path': '/poster.jpg',
        'backdrop_path': '/backdrop.jpg',
        'vote_average': 8.5,
        'release_date': '2024-01-01',
      };

      final result = Movie.fromJson(jsonMap);

      expect(result.id, tMovie.id);
      expect(result.title, tMovie.title);
      expect(result.overview, tMovie.overview);
      expect(result.posterPath, tMovie.posterPath);
      expect(result.backdropPath, tMovie.backdropPath);
      expect(result.voteAverage, tMovie.voteAverage);
      expect(result.releaseDate, tMovie.releaseDate);
    });

    test('fromJson should handle int/double conversion for vote_average', () {
      final jsonMapWithInt = {
        'id': 1,
        'title': 'Test Movie',
        'overview': 'Test Overview',
        'poster_path': '/poster.jpg',
        'backdrop_path': '/backdrop.jpg',
        'vote_average': 8, // int instead of double
        'release_date': '2024-01-01',
      };

      final result = Movie.fromJson(jsonMapWithInt);

      expect(result.voteAverage, 8.0);
    });
  });
}
