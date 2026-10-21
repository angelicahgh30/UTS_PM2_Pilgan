import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class ScoreRing extends StatelessWidget {
  final int score;
  final Color color;

  const ScoreRing({super.key, required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final size = (r.size.shortestSide * 0.4).clamp(130.0, 190.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score / 100),
      duration: const Duration(milliseconds: 1100),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) => SizedBox(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: value,
              strokeWidth: size * 0.075,
              strokeCap: StrokeCap.round,
              color: color,
              backgroundColor: color.withValues(alpha: 0.14),
            ),
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(value * 100).round()}',
                      style: context.texts.headlineLarge!.copyWith(
                        fontSize: size * 0.27,
                        color: color,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'dari 100',
                      style: r
                          .text(context.texts.bodySmall)
                          .copyWith(color: context.palette.muted),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
