import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cineflow/core/api/tmdb_provider.dart';
import 'package:cineflow/core/storage/storage_provider.dart';
import 'package:cineflow/features/movies/domain/repositories/movie_repository.dart';
import 'package:cineflow/features/movies/data/repositories/movie_repository_impl.dart';

part 'movie_repository_provider.g.dart';

@Riverpod(keepAlive: true)
Future<MovieRepository> movieRepository(MovieRepositoryRef ref) async {
  final tmdb = ref.watch(tmdbClientProvider);
  final movieBox = await ref.watch(movieBoxProvider.future);
  final favoritesBox = await ref.watch(favoritesBoxProvider.future);

  return MovieRepositoryImpl(
    tmdb: tmdb,
    movieBox: movieBox,
    favoritesBox: favoritesBox,
  );
}
