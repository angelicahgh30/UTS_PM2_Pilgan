import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../models/quiz_chapter.dart';
import 'app_card.dart';
import 'info_chip.dart';

class ChapterCard extends StatelessWidget {
  final QuizChapter chapter;
  final Color color;
  final int? bestScore;
  final VoidCallback onTap;

  const ChapterCard({
    super.key,
    required this.chapter,
    required this.color,
    required this.onTap,
    this.bestScore,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final done = bestScore != null;

    return AppCard(
      onTap: onTap,
      borderColor: done ? color.withValues(alpha: 0.5) : null,
      child: Row(
        children: [
          Container(
            width: r.sp(48),
            height: r.sp(48),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: done ? color : color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: done
                ? Icon(Icons.check_rounded, color: Colors.white, size: r.sp(26))
                : Text(
                    '${chapter.number}',
                    style: r
                        .text(context.texts.titleLarge)
                        .copyWith(color: color),
                  ),
          ),
          SizedBox(width: r.sp(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapter.label.toUpperCase(),
                  style: r
                      .text(context.texts.labelSmall)
                      .copyWith(color: color, letterSpacing: 0.8),
                ),
                SizedBox(height: r.sp(2)),
                Text(
                  chapter.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: r.text(context.texts.titleMedium),
                ),
                SizedBox(height: r.sp(2)),
                Text(
                  chapter.description,
                  maxLines: 2,
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
                    InfoChip(
                      icon: Icons.help_outline_rounded,
                      label: '${chapter.totalQuestions} soal',
                      color: palette.muted,
                      background: palette.border.withValues(alpha: 0.5),
                    ),
                    if (done)
                      InfoChip(
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
