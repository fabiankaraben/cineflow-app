import 'package:flutter/material.dart';
import 'package:cineflow/features/movies/domain/entities/movie.dart';
import 'package:cineflow/features/movies/presentation/widgets/movie_card.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 1200
              ? 6
              : MediaQuery.of(context).size.width > 800
              ? 4
              : 2,
          childAspectRatio: 0.67,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie);
        }, childCount: movies.length),
      ),
    );
  }
}
