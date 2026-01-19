import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cineflow/core/theme/theme_provider.dart';

class ThemeToggleButton extends ConsumerWidget {
  final Color? color;
  const ThemeToggleButton({super.key, this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
        color: color,
      ),
      onPressed: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
    );
  }
}
