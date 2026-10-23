import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../models/quiz_category.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/adaptive_grid.dart';
import '../widgets/page_container.dart';
import '../widgets/chapter_card.dart';
import '../widgets/section_header.dart';

class ChapterListScreen extends StatelessWidget {
  const ChapterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context)!.settings.arguments as QuizCategory?;
    if (category == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    final r = context.responsive;
    final palette = context.palette;
    final userId = context.watch<AuthProvider>().currentUser?.id ?? '';
    final history = context.watch<HistoryProvider>();
    final done = history.completedChapters(userId, category);

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih bab')),
      body: SafeArea(
        child: PageContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(r.sp(20)),
                decoration: BoxDecoration(
                  color: category.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(r.sp(20)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(r.sp(12)),
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(r.sp(14)),
                      ),
                      child: Icon(
                        category.icon,
                        color: Colors.white,
                        size: r.sp(28),
                      ),
                    ),
                    SizedBox(width: r.sp(14)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.title,
                            style: r.text(context.texts.titleLarge),
                          ),
                          SizedBox(height: r.sp(2)),
                          Text(
                            category.description,
                            style: r
                                .text(context.texts.bodySmall)
                                .copyWith(color: palette.muted),
                          ),
                          SizedBox(height: r.sp(10)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(r.sp(6)),
                            child: LinearProgressIndicator(
                              value: done / category.totalChapters,
                              minHeight: r.sp(6),
                              color: category.color,
                              backgroundColor: category.color.withValues(
                                alpha: 0.15,
                              ),
                            ),
                          ),
                          SizedBox(height: r.sp(6)),
                          Text(
                            '$done dari ${category.totalChapters} bab selesai',
                            style: r
                                .text(context.texts.labelMedium)
                                .copyWith(color: palette.muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: r.sp(24)),
              SectionHeader(
                title: 'Daftar bab',
                subtitle:
                    '${category.totalChapters} bab · '
                    '${category.totalQuestions} soal latihan',
              ),
              AdaptiveGrid(
                children: [
                  for (final chapter in category.chapters)
                    ChapterCard(
                      chapter: chapter,
                      color: category.color,
                      bestScore: history.bestChapterScore(userId, chapter.id),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.quizIntro,
                        arguments: (category, chapter),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
