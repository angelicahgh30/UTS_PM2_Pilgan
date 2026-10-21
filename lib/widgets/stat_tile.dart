import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'app_card.dart';

class StatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return AppCard(
      padding: EdgeInsets.symmetric(vertical: r.sp(14), horizontal: r.sp(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(r.sp(6)),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(r.sp(8)),
            ),
            child: Icon(icon, size: r.sp(18), color: color),
          ),
          SizedBox(height: r.sp(10)),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: r.text(context.texts.headlineSmall)),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: r
                .text(context.texts.bodySmall)
                .copyWith(color: context.palette.muted),
          ),
        ],
      ),
    );
  }
}
