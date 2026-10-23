import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/formatters.dart';
import '../core/utils/responsive.dart';
import '../models/quiz_category.dart';
import '../models/quiz_result.dart';
import 'app_card.dart';

class ResultTile extends StatelessWidget {
  final QuizResult result;
  final QuizCategory category;
  final VoidCallback? onTap;

  const ResultTile({
    super.key,
    required this.result,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final score = result.score;
    final color = score >= 80
        ? palette.success
        : (score >= 60 ? context.colors.primary : palette.danger);

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(r.sp(14)),
      child: Row(
        children: [
          Container(
            width: r.sp(44),
            height: r.sp(44),
            decoration: BoxDecoration(
              color: category.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(r.sp(12)),
            ),
            child: Icon(category.icon, color: category.color, size: r.sp(22)),
          ),
          SizedBox(width: r.sp(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.categoryTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: r.text(context.texts.titleSmall),
                ),
                SizedBox(height: r.sp(2)),
                Text(
                  'Bab ${result.chapterNumber}: ${result.chapterTitle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: r.text(context.texts.bodySmall),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${result.correct}/${result.total} benar',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: r
                            .text(context.texts.bodySmall)
                            .copyWith(color: palette.muted),
                      ),
                    ),
                  ],
                ),
                Text(
                  Formatters.dateTime(result.finishedAt),
                  style: r
                      .text(context.texts.labelSmall)
                      .copyWith(color: palette.muted),
                ),
              ],
            ),
          ),
          SizedBox(width: r.sp(8)),
          Container(
            width: r.sp(52),
            padding: EdgeInsets.symmetric(vertical: r.sp(8)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(r.sp(12)),
            ),
            child: Text(
              '$score',
              style: r.text(context.texts.titleLarge).copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
