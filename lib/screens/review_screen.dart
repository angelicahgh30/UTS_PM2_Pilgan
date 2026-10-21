import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/quiz_data.dart';
import '../models/quiz_result.dart';
import '../widgets/page_container.dart';
import '../widgets/review_tile.dart';

enum _Filter { all, correct, wrong }

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  _Filter _filter = _Filter.all;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final result = ModalRoute.of(context)!.settings.arguments as QuizResult?;
    if (result == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    final category = quizCategories.firstWhere(
      (c) => c.id == result.categoryId,
    );
    final questions = category.questions;
    final indexes = [
      for (var i = 0; i < questions.length; i++)
        if (_filter == _Filter.all ||
            (_filter == _Filter.correct) ==
                questions[i].isCorrect(result.answers[i]))
          i,
    ];

    final labels = {
      _Filter.all: 'Semua (${questions.length})',
      _Filter.correct: 'Benar (${result.correct})',
      _Filter.wrong: 'Salah (${questions.length - result.correct})',
    };

    return Scaffold(
      appBar: AppBar(title: Text('Pembahasan ${category.title}')),
      body: SafeArea(
        child: PageContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: r.sp(8),
                runSpacing: r.sp(8),
                children: [
                  for (final entry in labels.entries)
                    ChoiceChip(
                      label: Text(entry.value),
                      selected: _filter == entry.key,
                      onSelected: (_) => setState(() => _filter = entry.key),
                      showCheckmark: false,
                      selectedColor: context.palette.primarySoft,
                      labelStyle: r
                          .text(context.texts.labelMedium)
                          .copyWith(
                            color: _filter == entry.key
                                ? context.colors.primary
                                : context.palette.muted,
                          ),
                      side: BorderSide(
                        color: _filter == entry.key
                            ? context.colors.primary
                            : context.palette.border,
                      ),
                    ),
                ],
              ),
              SizedBox(height: r.sp(16)),
              if (indexes.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: r.sp(32)),
                  child: Text(
                    _filter == _Filter.wrong
                        ? 'Tidak ada jawaban yang salah. Mantap!'
                        : 'Belum ada jawaban yang benar.',
                    textAlign: TextAlign.center,
                    style: r
                        .text(context.texts.bodyMedium)
                        .copyWith(color: context.palette.muted),
                  ),
                ),
              for (final i in indexes)
                ReviewTile(
                  number: i + 1,
                  question: questions[i],
                  answer: result.answers[i],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
