import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';
import 'package:cineflow/features/movies/presentation/providers/movie_repository_provider.dart';

part 'movie_providers.g.dart';

@riverpod
Future<List<Movie>> popularMovies(PopularMoviesRef ref) async {
  final repository = await ref.watch(movieRepositoryProvider.future);
  return repository.getPopularMovies();
}

@riverpod
class Favorites extends _$Favorites {
  @override
  Future<List<Movie>> build() async {
    final repository = await ref.watch(movieRepositoryProvider.future);
    return repository.getFavoriteMovies();
  }

  Future<void> toggle(Movie movie) async {
    final repository = await ref.watch(movieRepositoryProvider.future);
    await repository.toggleFavorite(movie);
    ref.invalidateSelf();
  }

  Future<bool> isFavorite(int movieId) async {
    final repository = await ref.watch(movieRepositoryProvider.future);
    return repository.isFavorite(movieId);
  }
}

@riverpod
Future<List<Movie>> searchMovies(SearchMoviesRef ref, String query) async {
  if (query.isEmpty) return [];
  final repository = await ref.watch(movieRepositoryProvider.future);
  return repository.searchMovies(query);
}
