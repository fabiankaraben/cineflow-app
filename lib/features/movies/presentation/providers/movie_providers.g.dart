// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$popularMoviesHash() => r'94926ac98c3776d17545664517d99309a6b02ca9';

/// See also [popularMovies].
@ProviderFor(popularMovies)
final popularMoviesProvider = AutoDisposeFutureProvider<List<Movie>>.internal(
  popularMovies,
  name: r'popularMoviesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularMoviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PopularMoviesRef = AutoDisposeFutureProviderRef<List<Movie>>;
String _$searchMoviesHash() => r'ac6d68dca1b10b3b483e5b860f2654bae4dc4574';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchMovies].
@ProviderFor(searchMovies)
const searchMoviesProvider = SearchMoviesFamily();

/// See also [searchMovies].
class SearchMoviesFamily extends Family<AsyncValue<List<Movie>>> {
  /// See also [searchMovies].
  const SearchMoviesFamily();

  /// See also [searchMovies].
  SearchMoviesProvider call(
    String query,
  ) {
    return SearchMoviesProvider(
      query,
    );
  }

  @override
  SearchMoviesProvider getProviderOverride(
    covariant SearchMoviesProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchMoviesProvider';
}

/// See also [searchMovies].
class SearchMoviesProvider extends AutoDisposeFutureProvider<List<Movie>> {
  /// See also [searchMovies].
  SearchMoviesProvider(
    String query,
  ) : this._internal(
          (ref) => searchMovies(
            ref as SearchMoviesRef,
            query,
          ),
          from: searchMoviesProvider,
          name: r'searchMoviesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchMoviesHash,
          dependencies: SearchMoviesFamily._dependencies,
          allTransitiveDependencies:
              SearchMoviesFamily._allTransitiveDependencies,
          query: query,
        );

  SearchMoviesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Movie>> Function(SearchMoviesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchMoviesProvider._internal(
        (ref) => create(ref as SearchMoviesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Movie>> createElement() {
    return _SearchMoviesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchMoviesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchMoviesRef on AutoDisposeFutureProviderRef<List<Movie>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchMoviesProviderElement
    extends AutoDisposeFutureProviderElement<List<Movie>> with SearchMoviesRef {
  _SearchMoviesProviderElement(super.provider);

  @override
  String get query => (origin as SearchMoviesProvider).query;
}

String _$favoritesHash() => r'd338ec0b71b4446ad633cabf2a82bfee917bc3e4';

/// See also [Favorites].
@ProviderFor(Favorites)
final favoritesProvider =
    AutoDisposeAsyncNotifierProvider<Favorites, List<Movie>>.internal(
  Favorites.new,
  name: r'favoritesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favoritesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Favorites = AutoDisposeAsyncNotifier<List<Movie>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
