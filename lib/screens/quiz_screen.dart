import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../providers/quiz_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/adaptive_two_pane.dart';
import '../widgets/app_card.dart';
import '../widgets/feedback_panel.dart';
import '../widgets/option_card.dart';
import '../widgets/page_container.dart';
import '../widgets/timer_badge.dart';
import '../widgets/info_chip.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  late final QuizProvider _quiz;
  bool _dialogOpen = false;

  @override
  void initState() {
    super.initState();
    _quiz = context.read<QuizProvider>();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _quiz.resume());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _quiz.pause();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_dialogOpen) _quiz.resume();
    } else if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused) {
      _quiz.pause();
    }
  }

  Future<void> _confirmExit() async {
    if (_dialogOpen) return;
    _dialogOpen = true;
    _quiz.pause();
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text(
          'Progresmu disimpan. Kamu bisa melanjutkannya lagi dari beranda.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Lanjut mengerjakan'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    _dialogOpen = false;
    if (!mounted) return;
    if (leave == true) {
      Navigator.pop(context);
    } else {
      _quiz.resume();
    }
  }

  void _next() {
    if (!_quiz.isLastQuestion) {
      _quiz.nextQuestion();
      return;
    }
    _quiz.nextQuestion();
    final userId = context.read<AuthProvider>().currentUser?.id ?? '';
    context.read<HistoryProvider>().add(_quiz.toResult(userId));
    Navigator.pushReplacementNamed(context, AppRoutes.result);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    if (!quiz.isRunning) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    final r = context.responsive;
    final category = quiz.category!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: r.sp(64),
          leading: IconButton(
            tooltip: 'Keluar',
            onPressed: _confirmExit,
            icon: const Icon(Icons.close_rounded),
          ),
          title: Text(
            category.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            if (quiz.hasTimer)
              Padding(
                padding: EdgeInsets.only(right: r.sp(16)),
                child: TimerBadge(
                  seconds: quiz.remainingSeconds,
                  fraction: quiz.timeFraction,
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: PageContainer(child: _QuestionBody(quiz: quiz)),
        ),
        bottomNavigationBar: quiz.isRevealed
            ? FeedbackPanel(
                type: quiz.currentTimedOut
                    ? FeedbackType.timeout
                    : (quiz.currentQuestion.isCorrect(quiz.currentAnswer)
                          ? FeedbackType.correct
                          : FeedbackType.wrong),
                combo: quiz.combo,
                correctAnswer:
                    '${String.fromCharCode(65 + quiz.currentQuestion.correctIndex)}. '
                    '${quiz.currentQuestion.correctAnswer}',
                explanation: quiz.currentQuestion.explanation,
                buttonLabel: quiz.isLastQuestion
                    ? 'Lihat hasil'
                    : 'Soal berikutnya',
                onNext: _next,
              )
            : null,
      ),
    );
  }
}

class _QuestionBody extends StatelessWidget {
  final QuizProvider quiz;

  const _QuestionBody({required this.quiz});

  OptionState _stateOf(int i) {
    if (!quiz.isRevealed) return OptionState.idle;
    if (i == quiz.currentQuestion.correctIndex) return OptionState.correct;
    if (i == quiz.currentAnswer) return OptionState.wrong;
    return OptionState.dimmed;
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final question = quiz.currentQuestion;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Soal ${quiz.currentIndex + 1} dari ${quiz.totalQuestions}',
                style: r
                    .text(context.texts.titleSmall)
                    .copyWith(color: palette.muted),
              ),
            ),
            if (quiz.combo >= 2) ...[
              Icon(
                Icons.local_fire_department_rounded,
                size: r.sp(18),
                color: palette.warning,
              ),
              Text(
                '${quiz.combo}x ',
                style: r
                    .text(context.texts.labelMedium)
                    .copyWith(color: palette.warning),
              ),
              SizedBox(width: r.sp(6)),
            ],
            InfoChip(
              icon: Icons.check_circle_outline_rounded,
              label: '${quiz.correctCount} benar',
              color: palette.success,
              background: palette.successSoft,
            ),
          ],
        ),
        SizedBox(height: r.sp(10)),
        ClipRRect(
          borderRadius: BorderRadius.circular(r.sp(8)),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: quiz.progress),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, _) =>
                LinearProgressIndicator(value: value, minHeight: r.sp(8)),
          ),
        ),
        SizedBox(height: r.sp(20)),
        AdaptiveTwoPane(
          first: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: AppCard(
              key: ValueKey(quiz.currentIndex),
              padding: EdgeInsets.all(r.sp(20)),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  question.text,
                  style: r
                      .text(context.texts.titleLarge)
                      .copyWith(height: 1.45),
                ),
              ),
            ),
          ),
          second: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < question.options.length; i++)
                OptionCard(
                  index: i,
                  text: question.options[i],
                  state: _stateOf(i),
                  onTap: quiz.isRevealed ? null : () => quiz.selectAnswer(i),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
