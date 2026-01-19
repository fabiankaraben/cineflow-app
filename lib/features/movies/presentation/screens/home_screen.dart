import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movie_providers.dart';
import '../widgets/movie_grid.dart';
import '../widgets/featured_movie_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMoviesAsync = ref.watch(popularMoviesProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(popularMoviesProvider.future),
        child: CustomScrollView(
          slivers: [
            popularMoviesAsync.when(
              data: (movies) => FeaturedMovieHeader(movie: movies.first),
              loading: () =>
                  const SliverToBoxAdapter(child: SizedBox(height: 300)),
              error: (_, __) =>
                  const SliverToBoxAdapter(child: SizedBox(height: 300)),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Popular Movies',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            popularMoviesAsync.when(
              data: (movies) => MovieGrid(movies: movies),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverFillRemaining(
                child: Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
