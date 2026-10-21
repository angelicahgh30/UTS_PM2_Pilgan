import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final Color? background;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final fg = color ?? context.colors.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.sp(10), vertical: r.sp(5)),
      decoration: BoxDecoration(
        color: background ?? context.palette.primarySoft,
        borderRadius: BorderRadius.circular(r.sp(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: r.sp(16), color: fg),
          SizedBox(width: r.sp(4)),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: r
                  .text(context.texts.labelMedium)
                  .copyWith(color: fg, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
