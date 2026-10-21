import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: r.text(context.texts.titleLarge)),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: r
                        .text(context.texts.bodySmall)
                        .copyWith(color: context.palette.muted),
                  ),
              ],
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
