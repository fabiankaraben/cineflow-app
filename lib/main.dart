import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cineflow/core/theme/cineflow_theme.dart';
import 'package:cineflow/core/router/router_provider.dart';
import 'package:cineflow/core/storage/storage_provider.dart';
import 'package:cineflow/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await StorageService.init();

  runApp(const ProviderScope(child: CineFlowApp()));
}

class CineFlowApp extends ConsumerWidget {
  const CineFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'CineFlow',
      theme: CineFlowTheme.lightTheme,
      darkTheme: CineFlowTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
