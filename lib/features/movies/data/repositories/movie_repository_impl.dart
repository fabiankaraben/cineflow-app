import 'package:hive_flutter/hive_flutter.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:dio/dio.dart';
import 'package:cineflow/core/api/mock_movie_data.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';
import 'package:cineflow/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final TMDB tmdb;
  final Box movieBox;
  final Box favoritesBox;

  MovieRepositoryImpl({
    required this.tmdb,
    required this.movieBox,
    required this.favoritesBox,
  });

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      // If we know the keys are placeholders, skip the request and return mock data immediately
      // This avoids the internal logging of 401 errors from tmdb_api
      // Note: We check the internal key from tmdb.v3.apiKey if possible,
      // but simpler to just try and catch aggressively.

      final response = await tmdb.v3.movies.getPopular(page: page);
      final List results = response['results'];
      final movies = results.map((m) => Movie.fromJson(m)).toList();

      if (page == 1) {
        await movieBox.put(
          'popular_movies',
          movies.map((m) => m.toJson()).toList(),
        );
      }

      return movies;
    } catch (e) {
      // LOG error for debugging
      print('CineFlow: Caught error in getPopularMovies: $e');

      // Broad fallback for any authentication/request error
      if (e.toString().contains('401') ||
          e.toString().contains('Unauthorized') ||
          e.toString().contains('bad response')) {
        return mockMovies;
      }

      // Return cached movies if offline
      if (page == 1) {
        final cached = movieBox.get('popular_movies');
        if (cached != null) {
          return (cached as List)
              .map((m) => Movie.fromJson(Map<String, dynamic>.from(m)))
              .toList();
        }
      }

      // If everything else fails, return mock data to avoid a blank screen
      return mockMovies;
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    try {
      if (query.isEmpty) return [];
      final response = await tmdb.v3.search.queryMovies(query, page: page);
      final List results = response['results'];
      return results.map((m) => Movie.fromJson(m)).toList();
    } catch (e) {
      print('CineFlow: Caught error in searchMovies: $e');
      if (e.toString().contains('401') ||
          e.toString().contains('Unauthorized') ||
          e.toString().contains('bad response')) {
        return mockMovies
            .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      return [];
    }
  }

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    final List favorites = favoritesBox.values.toList();
    return favorites
        .map((m) => Movie.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    if (favoritesBox.containsKey(movie.id)) {
      await favoritesBox.delete(movie.id);
    } else {
      await favoritesBox.put(movie.id, movie.toJson());
    }
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    return favoritesBox.containsKey(movieId);
  }
}
