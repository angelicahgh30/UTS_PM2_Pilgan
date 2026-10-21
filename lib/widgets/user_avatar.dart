import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class UserAvatar extends StatelessWidget {
  final String initials;
  final double size;

  final bool onDark;

  const UserAvatar({
    super.key,
    required this.initials,
    this.size = 44,
    this.onDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final s = r.sp(size);
    final (Color bg, Color fg) = onDark
        ? (AppColors.accent, AppColors.navy)
        : (context.palette.primarySoft, context.colors.primary);

    return Container(
      width: s,
      height: s,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bg,
        border: Border.all(
          color: onDark ? Colors.white.withValues(alpha: 0.6) : fg,
          width: 2,
        ),
      ),
      child: Text(
        initials,
        style: context.texts.titleMedium!.copyWith(
          fontSize: s * 0.36,
          color: fg,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
