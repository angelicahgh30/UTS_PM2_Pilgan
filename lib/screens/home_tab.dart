import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/quiz_data.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../providers/quiz_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/adaptive_grid.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/category_card.dart';
import '../widgets/navy_header_layout.dart';
import '../widgets/section_header.dart';
import '../widgets/stat_tile.dart';
import '../widgets/user_avatar.dart';
import '../widgets/progress_banner.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat pagi,';
    if (hour < 15) return 'Selamat siang,';
    if (hour < 18) return 'Selamat sore,';
    return 'Selamat malam,';
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final user = context.watch<AuthProvider>().currentUser;
    final history = context.watch<HistoryProvider>();
    if (user == null) return const SizedBox.shrink();

    final userId = user.id;
    final totalQuestions = quizCategories.fold<int>(
      0,
      (sum, c) => sum + c.totalQuestions,
    );

    return NavyHeaderLayout(
      headerHeight: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              UserAvatar(initials: user.initials, onDark: true),
              SizedBox(width: r.sp(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting(),
                      style: r.text(context.texts.bodySmall).onNavyMuted,
                    ),
                    Text(
                      user.firstName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: r.text(context.texts.headlineSmall).onNavy,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(24)),
          ProgressBanner(
            done: history.triedCategories(userId),
            total: quizCategories.length,
          ),
          const _ResumeCard(),
          SizedBox(height: r.sp(16)),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  icon: Icons.task_alt_rounded,
                  value: '${history.resultsOf(userId).length}',
                  label: 'Kuis selesai',
                  color: context.colors.primary,
                ),
              ),
              SizedBox(width: r.sp(10)),
              Expanded(
                child: StatTile(
                  icon: Icons.bar_chart_rounded,
                  value: '${history.averageScore(userId)}',
                  label: 'Rata-rata nilai',
                  color: context.palette.success,
                ),
              ),
              SizedBox(width: r.sp(10)),
              Expanded(
                child: StatTile(
                  icon: Icons.local_fire_department_rounded,
                  value: '${history.bestCombo(userId)}x',
                  label: 'Rekor combo',
                  color: context.palette.warning,
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(24)),
          SectionHeader(
            title: 'Pilih materi',
            subtitle:
                '${quizCategories.length} materi · $totalQuestions soal latihan',
          ),
          AdaptiveGrid(
            children: [
              for (final category in quizCategories)
                CategoryCard(
                  category: category,
                  bestScore: history.bestScore(userId, category.id),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.quizIntro,
                    arguments: category,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResumeCard extends StatelessWidget {
  const _ResumeCard();

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final quiz = context.watch<QuizProvider>();
    final category = quiz.category;
    if (!quiz.isRunning || category == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: r.sp(16)),
      child: AppCard(
        borderColor: context.colors.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(category.icon, color: category.color, size: r.sp(22)),
                SizedBox(width: r.sp(8)),
                Expanded(
                  child: Text(
                    'Kuis ${category.title} belum selesai',
                    style: r.text(context.texts.titleSmall),
                  ),
                ),
              ],
            ),
            SizedBox(height: r.sp(10)),
            ClipRRect(
              borderRadius: BorderRadius.circular(r.sp(6)),
              child: LinearProgressIndicator(
                value: quiz.progress,
                minHeight: r.sp(6),
              ),
            ),
            SizedBox(height: r.sp(6)),
            Text(
              'Soal ${quiz.currentIndex + 1} dari ${quiz.totalQuestions}',
              style: r
                  .text(context.texts.bodySmall)
                  .copyWith(color: context.palette.muted),
            ),
            SizedBox(height: r.sp(12)),
            AppButton(
              label: 'Lanjutkan kuis',
              icon: Icons.play_arrow_rounded,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.quiz),
            ),
          ],
        ),
      ),
    );
  }
}
