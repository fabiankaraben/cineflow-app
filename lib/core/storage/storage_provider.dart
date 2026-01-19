import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Box> movieBox(MovieBoxRef ref) async {
  return await Hive.openBox('movies_box');
}

@Riverpod(keepAlive: true)
Future<Box> favoritesBox(FavoritesBoxRef ref) async {
  return await Hive.openBox('favorites_box');
}

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    // Register adapters here if needed
  }
}
