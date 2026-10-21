import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  final Color? color;

  const ThemeToggleButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final dark = theme.isDark(context);

    return IconButton(
      tooltip: dark ? 'Mode terang' : 'Mode gelap',
      color: color,
      onPressed: () => theme.setDark(!dark),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) =>
            RotationTransition(turns: anim, child: child),
        child: Icon(
          dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(dark),
        ),
      ),
    );
  }
}
