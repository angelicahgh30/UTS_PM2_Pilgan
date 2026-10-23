import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../models/quiz_category.dart';
import '../models/quiz_chapter.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../providers/quiz_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/adaptive_two_pane.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/page_container.dart';

class QuizIntroScreen extends StatelessWidget {
  const QuizIntroScreen({super.key});

  void _start(
    BuildContext context,
    QuizCategory category,
    QuizChapter chapter,
  ) {
    final user = context.read<AuthProvider>().currentUser;
    context.read<QuizProvider>()
      ..setUserName(user?.name ?? '')
      ..startQuiz(category, chapter);
    Navigator.pushReplacementNamed(context, AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final args =
        ModalRoute.of(context)!.settings.arguments
            as (QuizCategory, QuizChapter)?;
    if (args == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }
    final (category, chapter) = args;

    final quiz = context.read<QuizProvider>();
    final userId = context.watch<AuthProvider>().currentUser?.id ?? '';
    final history = context.watch<HistoryProvider>();
    final best = history.bestChapterScore(userId, chapter.id);

    return Scaffold(
      appBar: AppBar(title: Text(chapter.label)),
      body: SafeArea(
        child: PageContainer(
          child: AdaptiveTwoPane(
            first: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(r.sp(20)),
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(r.sp(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: r.sp(14)),
                      Text(
                        '${category.title} · ${chapter.label}',
                        style: r
                            .text(context.texts.labelMedium)
                            .copyWith(color: category.color),
                      ),
                      SizedBox(height: r.sp(4)),
                      Text(
                        chapter.title,
                        style: r.text(context.texts.headlineMedium),
                      ),
                      SizedBox(height: r.sp(4)),
                      Text(
                        chapter.description,
                        style: r
                            .text(context.texts.bodyMedium)
                            .copyWith(color: palette.muted),
                      ),
                      if (best != null) ...[
                        SizedBox(height: r.sp(10)),
                        Text(
                          'Nilai terbaikmu: $best',
                          style: r
                              .text(context.texts.titleSmall)
                              .copyWith(color: palette.success),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: r.sp(16)),
                Row(
                  children: [
                    _InfoBox(
                      icon: Icons.help_outline_rounded,
                      value: '${chapter.totalQuestions}',
                      label: 'Soal',
                    ),
                    SizedBox(width: r.sp(10)),
                    _InfoBox(
                      icon: Icons.timer_outlined,
                      value: '${quiz.secondsPerQuestion}s',
                      label: 'Per soal',
                    ),
                    SizedBox(width: r.sp(10)),
                    _InfoBox(
                      icon: Icons.schedule_outlined,
                      value:
                          '${(chapter.totalQuestions * quiz.secondsPerQuestion / 60).ceil()}m',
                      label: 'Maks. durasi',
                    ),
                  ],
                ),
              ],
            ),
            second: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cara bermain',
                        style: r.text(context.texts.titleMedium),
                      ),
                      SizedBox(height: r.sp(10)),
                      const _Rule(
                        'Pilih satu jawaban. Jawaban langsung dinilai '
                        'dan tidak bisa diganti.',
                      ),
                      const _Rule(
                        'Jawab benar berturut-turut untuk membuat combo. '
                        'Rekor combo tercatat di riwayat.',
                      ),
                      const _Rule('Jika waktu habis, soal dianggap salah.'),
                    ],
                  ),
                ),
                SizedBox(height: r.sp(24)),
                AppButton(
                  label: 'Mulai kuis',
                  icon: Icons.play_arrow_rounded,
                  onPressed: () => _start(context, category, chapter),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoBox({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Expanded(
      child: AppCard(
        padding: EdgeInsets.symmetric(vertical: r.sp(14), horizontal: r.sp(8)),
        child: Column(
          children: [
            Icon(icon, color: context.colors.primary, size: r.sp(22)),
            SizedBox(height: r.sp(6)),
            Text(value, style: r.text(context.texts.titleLarge)),
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
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  final String text;

  const _Rule(this.text);

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: r.sp(2)),
            child: Icon(
              Icons.check_circle_outline_rounded,
              size: r.sp(18),
              color: context.palette.success,
            ),
          ),
          SizedBox(width: r.sp(8)),
          Expanded(child: Text(text, style: r.text(context.texts.bodyMedium))),
        ],
      ),
    );
  }
}
