import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class TimerBadge extends StatelessWidget {
  final int seconds;
  final double fraction;

  const TimerBadge({super.key, required this.seconds, required this.fraction});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final color = fraction > 0.5
        ? context.colors.primary
        : (fraction > 0.25 ? palette.warning : palette.danger);
    final size = r.sp(42);

    return Semantics(
      label: 'Sisa waktu $seconds detik',
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(end: fraction),
              duration: const Duration(milliseconds: 900),
              builder: (context, value, _) => CircularProgressIndicator(
                value: value,
                strokeWidth: r.sp(3.5),
                strokeCap: StrokeCap.round,
                color: color,
                backgroundColor: color.withValues(alpha: 0.15),
              ),
            ),
            Center(
              child: Text(
                '$seconds',
                style: r.text(context.texts.titleMedium).copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
