import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cineflow/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:cineflow/core/api/mock_movie_data.dart';

class MockTMDB extends Mock implements TMDB {}

class MockBox extends Mock implements Box {}

class MockTmdbV3 extends Mock implements V3 {}

class MockTmdbMovies extends Mock implements Movies {}

class MockTmdbSearch extends Mock implements Search {}

void main() {
  late MovieRepositoryImpl repository;
  late MockTMDB mockTmdb;
  late MockBox mockMovieBox;
  late MockBox mockFavoritesBox;
  late MockTmdbV3 mockTmdbV3;
  late MockTmdbMovies mockTmdbMovies;
  late MockTmdbSearch mockTmdbSearch;

  setUp(() {
    mockTmdb = MockTMDB();
    mockMovieBox = MockBox();
    mockFavoritesBox = MockBox();
    mockTmdbV3 = MockTmdbV3();
    mockTmdbMovies = MockTmdbMovies();
    mockTmdbSearch = MockTmdbSearch();

    when(() => mockTmdb.v3).thenReturn(mockTmdbV3);
    when(() => mockTmdbV3.movies).thenReturn(mockTmdbMovies);
    when(() => mockTmdbV3.search).thenReturn(mockTmdbSearch);

    repository = MovieRepositoryImpl(
      tmdb: mockTmdb,
      movieBox: mockMovieBox,
      favoritesBox: mockFavoritesBox,
    );
  });

  group('getPopularMovies', () {
    final tMovieMap = {
      'id': 1,
      'title': 'Test Movie',
      'overview': 'Test Overview',
      'poster_path': '/poster.jpg',
      'backdrop_path': '/backdrop.jpg',
      'vote_average': 8.5,
      'release_date': '2024-01-01',
    };
    final tMovie = Movie.fromJson(tMovieMap);

    test(
      'should return parsed movies from TMDB on success and cache them when page is 1',
      () async {
        // arrange
        final tmdbResponse = {
          'results': [tMovieMap],
        };
        when(
          () => mockTmdbMovies.getPopular(page: 1),
        ).thenAnswer((_) async => tmdbResponse);
        when(() => mockMovieBox.put(any(), any())).thenAnswer((_) async => {});

        // act
        final result = await repository.getPopularMovies(page: 1);

        // assert
        expect(result.length, 1);
        expect(result.first.id, tMovie.id);
        verify(() => mockTmdbMovies.getPopular(page: 1)).called(1);
        verify(() => mockMovieBox.put('popular_movies', any())).called(1);
      },
    );

    test(
      'should return cached movies when TMDB throws a generic exception on page 1',
      () async {
        // arrange
        when(
          () => mockTmdbMovies.getPopular(page: 1),
        ).thenThrow(Exception('No Internet'));
        when(() => mockMovieBox.get('popular_movies')).thenReturn([tMovieMap]);

        // act
        final result = await repository.getPopularMovies(page: 1);

        // assert
        expect(result.length, 1);
        expect(result.first.id, tMovie.id);
        verify(() => mockTmdbMovies.getPopular(page: 1)).called(1);
        verify(() => mockMovieBox.get('popular_movies')).called(1);
      },
    );

    test(
      'should return mockMovies when an Unauthorized exception occurs',
      () async {
        // arrange
        when(
          () => mockTmdbMovies.getPopular(page: 1),
        ).thenThrow(Exception('401 Unauthorized'));

        // act
        final result = await repository.getPopularMovies(page: 1);

        // assert
        expect(
          result.length,
          mockMovies.length,
        ); // Should fallback to mock data
        expect(result.first.id, mockMovies.first.id);
        verify(() => mockTmdbMovies.getPopular(page: 1)).called(1);
      },
    );
  });

  group('searchMovies', () {
    final tMovieMap = {
      'id': 1,
      'title': 'Test Movie Query',
      'overview': 'Test Overview',
      'poster_path': '/poster.jpg',
      'backdrop_path': '/backdrop.jpg',
      'vote_average': 8.5,
      'release_date': '2024-01-01',
    };

    test('should return movies based on search query', () async {
      // arrange
      final tmdbResponse = {
        'results': [tMovieMap],
      };
      when(
        () => mockTmdbSearch.queryMovies('Test', page: 1),
      ).thenAnswer((_) async => tmdbResponse);

      // act
      final result = await repository.searchMovies('Test', page: 1);

      // assert
      expect(result.length, 1);
      expect(result.first.title, 'Test Movie Query');
      verify(() => mockTmdbSearch.queryMovies('Test', page: 1)).called(1);
    });

    test('should return empty list when query is empty', () async {
      // act
      final result = await repository.searchMovies('');

      // assert
      expect(result, isEmpty);
      verifyNever(() => mockTmdbSearch.queryMovies(any()));
    });
  });

  group('favoriteMovies', () {
    final tMovieMap = {
      'id': 1,
      'title': 'Test Movie',
      'overview': 'Test Overview',
      'poster_path': '/poster.jpg',
      'backdrop_path': '/backdrop.jpg',
      'vote_average': 8.5,
      'release_date': '2024-01-01',
    };
    final tMovie = Movie.fromJson(tMovieMap);

    test('getFavoriteMovies should return list from favoritesBox', () async {
      // arrange
      when(() => mockFavoritesBox.values).thenReturn([tMovieMap]);

      // act
      final result = await repository.getFavoriteMovies();

      // assert
      expect(result.length, 1);
      expect(result.first.id, tMovie.id);
      verify(() => mockFavoritesBox.values).called(1);
    });

    test(
      'toggleFavorite should delete from box when already favorited',
      () async {
        // arrange
        when(() => mockFavoritesBox.containsKey(tMovie.id)).thenReturn(true);
        when(
          () => mockFavoritesBox.delete(tMovie.id),
        ).thenAnswer((_) async => {});

        // act
        await repository.toggleFavorite(tMovie);

        // assert
        verify(() => mockFavoritesBox.containsKey(tMovie.id)).called(1);
        verify(() => mockFavoritesBox.delete(tMovie.id)).called(1);
        verifyNever(() => mockFavoritesBox.put(any(), any()));
      },
    );

    test('toggleFavorite should add to box when not favorited', () async {
      // arrange
      when(() => mockFavoritesBox.containsKey(tMovie.id)).thenReturn(false);
      when(
        () => mockFavoritesBox.put(tMovie.id, any()),
      ).thenAnswer((_) async => {});

      // act
      await repository.toggleFavorite(tMovie);

      // assert
      verify(() => mockFavoritesBox.containsKey(tMovie.id)).called(1);
      verify(() => mockFavoritesBox.put(tMovie.id, any())).called(1);
      verifyNever(() => mockFavoritesBox.delete(any()));
    });

    test('isFavorite should return true if box contains key', () async {
      // arrange
      when(() => mockFavoritesBox.containsKey(tMovie.id)).thenReturn(true);

      // act
      final result = await repository.isFavorite(tMovie.id);

      // assert
      expect(result, isTrue);
      verify(() => mockFavoritesBox.containsKey(tMovie.id)).called(1);
    });
  });
}
