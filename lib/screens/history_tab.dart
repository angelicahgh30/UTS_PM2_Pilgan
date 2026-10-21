import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/quiz_data.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/adaptive_two_pane.dart';
import '../widgets/app_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/navy_header_layout.dart';
import '../widgets/result_tile.dart';
import '../widgets/section_header.dart';
import '../widgets/stat_tile.dart';

class HistoryTab extends StatelessWidget {
  final VoidCallback onStartLearning;

  const HistoryTab({super.key, required this.onStartLearning});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final userId = context.watch<AuthProvider>().currentUser?.id ?? '';
    final history = context.watch<HistoryProvider>();
    final results = history.resultsOf(userId);

    if (results.isEmpty) {
      return NavyHeaderLayout(
        headerHeight: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const NavyTitle(title: 'Riwayat belajar'),
            EmptyState(
              title: 'Belum ada riwayat',
              message:
                  'Kerjakan kuis pertamamu. Hasil dan nilainya akan '
                  'muncul di sini.',
              actionLabel: 'Mulai belajar',
              onAction: onStartLearning,
            ),
          ],
        ),
      );
    }

    return NavyHeaderLayout(
      headerHeight: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const NavyTitle(
            title: 'Riwayat belajar',
            subtitle: 'Pantau perkembangan nilaimu',
          ),
          AdaptiveTwoPane(
            first: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        icon: Icons.task_alt_rounded,
                        value: '${results.length}',
                        label: 'Kuis selesai',
                        color: context.colors.primary,
                      ),
                    ),
                    SizedBox(width: r.sp(10)),
                    Expanded(
                      child: StatTile(
                        icon: Icons.bar_chart_rounded,
                        value: '${history.averageScore(userId)}',
                        label: 'Rata-rata',
                        color: context.palette.success,
                      ),
                    ),
                    SizedBox(width: r.sp(10)),
                    Expanded(
                      child: StatTile(
                        icon: Icons.auto_stories_outlined,
                        value:
                            '${history.triedCategories(userId)}/${quizCategories.length}',
                        label: 'Materi dicoba',
                        color: context.palette.accent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.sp(20)),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nilai terbaik per materi',
                        style: r.text(context.texts.titleMedium),
                      ),
                      SizedBox(height: r.sp(14)),
                      for (final category in quizCategories)
                        _BestScoreRow(
                          icon: category.icon,
                          color: category.color,
                          title: category.title,
                          score: history.bestScore(userId, category.id),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            second: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  title: 'Kuis terakhir',
                  subtitle: 'Ketuk untuk melihat pembahasan',
                ),
                for (final result in results)
                  Padding(
                    padding: EdgeInsets.only(bottom: r.sp(10)),
                    child: ResultTile(
                      result: result,
                      category: quizCategories.firstWhere(
                        (c) => c.id == result.categoryId,
                      ),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.review,
                        arguments: result,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BestScoreRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final int? score;

  const _BestScoreRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(14)),
      child: Row(
        children: [
          Icon(icon, color: color, size: r.sp(20)),
          SizedBox(width: r.sp(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: r.text(context.texts.bodyMedium),
                      ),
                    ),
                    SizedBox(width: r.sp(8)),
                    Flexible(
                      child: Text(
                        score == null ? 'Belum dikerjakan' : '$score',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: r
                            .text(context.texts.labelMedium)
                            .copyWith(
                              color: score == null ? palette.muted : color,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.sp(6)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(r.sp(6)),
                  child: LinearProgressIndicator(
                    value: (score ?? 0) / 100,
                    minHeight: r.sp(6),
                    color: color,
                    backgroundColor: color.withValues(alpha: 0.12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
