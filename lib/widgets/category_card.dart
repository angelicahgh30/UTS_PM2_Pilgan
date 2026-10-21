import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../models/quiz_category.dart';
import 'app_card.dart';

class CategoryCard extends StatelessWidget {
  final QuizCategory category;
  final int? bestScore;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.bestScore,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: r.sp(52),
            height: r.sp(52),
            decoration: BoxDecoration(
              color: category.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(r.sp(14)),
            ),
            child: Icon(category.icon, color: category.color, size: r.sp(26)),
          ),
          SizedBox(width: r.sp(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: r.text(context.texts.titleMedium),
                ),
                SizedBox(height: r.sp(2)),
                Text(
                  category.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: r
                      .text(context.texts.bodySmall)
                      .copyWith(color: palette.muted),
                ),
                SizedBox(height: r.sp(8)),
                Wrap(
                  spacing: r.sp(6),
                  runSpacing: r.sp(6),
                  children: [
                    _Tag(
                      icon: Icons.help_outline_rounded,
                      label: '${category.totalQuestions} soal',
                      color: palette.muted,
                      background: palette.border.withValues(alpha: 0.5),
                    ),
                    if (bestScore != null)
                      _Tag(
                        icon: Icons.emoji_events_outlined,
                        label: 'Terbaik $bestScore',
                        color: palette.success,
                        background: palette.successSoft,
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: r.sp(8)),
          Icon(
            Icons.chevron_right_rounded,
            color: palette.muted,
            size: r.sp(24),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color background;

  const _Tag({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.sp(8), vertical: r.sp(3)),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(r.sp(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: r.sp(13), color: color),
          SizedBox(width: r.sp(4)),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: r.text(context.texts.labelSmall).copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
