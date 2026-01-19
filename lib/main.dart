import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/cineflow_theme.dart';
import 'core/router/router_provider.dart';
import 'core/storage/storage_provider.dart';

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

    return MaterialApp.router(
      title: 'CineFlow',
      theme: CineFlowTheme.lightTheme,
      darkTheme: CineFlowTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
