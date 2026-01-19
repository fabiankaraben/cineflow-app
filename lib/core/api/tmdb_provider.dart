import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_api/tmdb_api.dart';

part 'tmdb_provider.g.dart';

@riverpod
TMDB tmdbClient(TmdbClientRef ref) {
  // NOTE: In a real app, use environment variables for API keys
  return TMDB(
    ApiKeys('YOUR_API_KEY_HERE', 'YOUR_READ_ACCESS_TOKEN_HERE'),
    logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
  );
}
