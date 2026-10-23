import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/formatters.dart';
import '../core/utils/responsive.dart';
import '../providers/auth_provider.dart';
import '../providers/quiz_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/adaptive_two_pane.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/navy_header_layout.dart';
import '../widgets/score_ring.dart';
import '../widgets/stat_tile.dart';
import '../widgets/info_chip.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  void _home(BuildContext context) {
    context.read<QuizProvider>().resetQuiz();
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_) => false);
  }

  void _retry(BuildContext context) {
    context.read<QuizProvider>().restartQuiz();
    Navigator.pushReplacementNamed(context, AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    if (!quiz.isFinished || quiz.chapter == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    final r = context.responsive;
    final palette = context.palette;
    final user = context.watch<AuthProvider>().currentUser;
    final name = user?.firstName ?? quiz.userName;
    final userId = user?.id ?? '';
    final score = quiz.score;

    final (Color color, String title, String message) = score >= 80
        ? (
            palette.success,
            'Luar biasa, $name!',
            'Kamu sudah menguasai materi ini dengan baik.',
          )
        : score >= 60
        ? (
            context.colors.primary,
            'Kerja bagus, $name!',
            'Sedikit lagi menuju nilai sempurna.',
          )
        : (
            palette.danger,
            'Tetap semangat, $name!',
            'Pelajari pembahasannya, lalu coba lagi.',
          );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _home(context);
      },
      child: Scaffold(
        body: NavyHeaderLayout(
          headerHeight: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NavyTitle(
                title: 'Hasil kuis',
                subtitle:
                    '${quiz.category!.title} · ${quiz.chapter!.label}: '
                    '${quiz.chapter!.title}',
              ),
              AdaptiveTwoPane(
                first: AppCard(
                  padding: EdgeInsets.all(r.sp(24)),
                  child: Column(
                    children: [
                      ScoreRing(score: score, color: color),
                      SizedBox(height: r.sp(12)),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: r.text(context.texts.headlineSmall),
                      ),
                      SizedBox(height: r.sp(4)),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: r
                            .text(context.texts.bodyMedium)
                            .copyWith(color: palette.muted),
                      ),
                      SizedBox(height: r.sp(14)),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: r.sp(8),
                        runSpacing: r.sp(8),
                        children: [
                          InfoChip(
                            icon: Icons.local_fire_department_rounded,
                            label: 'Combo ${quiz.bestCombo}x',
                          ),
                          InfoChip(
                            icon: Icons.schedule_rounded,
                            label: Formatters.duration(quiz.elapsed),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                second: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatTile(
                            icon: Icons.check_circle_outline_rounded,
                            value: '${quiz.correctCount}',
                            label: 'Benar',
                            color: palette.success,
                          ),
                        ),
                        SizedBox(width: r.sp(10)),
                        Expanded(
                          child: StatTile(
                            icon: Icons.highlight_off_rounded,
                            value: '${quiz.wrongCount}',
                            label: 'Salah',
                            color: palette.danger,
                          ),
                        ),
                        SizedBox(width: r.sp(10)),
                        Expanded(
                          child: StatTile(
                            icon: Icons.timer_off_outlined,
                            value: '${quiz.timedOutCount}',
                            label: 'Waktu habis',
                            color: palette.warning,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: r.sp(20)),
                    AppButton(
                      label: 'Lihat pembahasan',
                      icon: Icons.menu_book_rounded,
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.review,
                        arguments: quiz.toResult(userId),
                      ),
                    ),
                    SizedBox(height: r.sp(12)),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton.outlined(
                            label: 'Ulangi',
                            icon: Icons.replay_rounded,
                            onPressed: () => _retry(context),
                          ),
                        ),
                        SizedBox(width: r.sp(12)),
                        Expanded(
                          child: AppButton.outlined(
                            label: 'Beranda',
                            icon: Icons.home_outlined,
                            onPressed: () => _home(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
