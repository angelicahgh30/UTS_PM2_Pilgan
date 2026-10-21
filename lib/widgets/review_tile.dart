import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../models/question.dart';
import 'app_card.dart';

class ReviewTile extends StatelessWidget {
  final int number;
  final Question question;
  final int? answer;

  const ReviewTile({
    super.key,
    required this.number,
    required this.question,
    required this.answer,
  });

  String _option(int i) =>
      '${String.fromCharCode(65 + i)}. ${question.options[i]}';

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final correct = question.isCorrect(answer);
    final color = correct
        ? palette.success
        : (answer == null ? palette.warning : palette.danger);
    final status = correct
        ? 'Benar'
        : (answer == null ? 'Waktu habis' : 'Salah');

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(12)),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: r.sp(30),
                  height: r.sp(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(r.sp(8)),
                  ),
                  child: Text(
                    '$number',
                    style: r
                        .text(context.texts.labelLarge)
                        .copyWith(color: color),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.sp(10),
                    vertical: r.sp(4),
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(r.sp(20)),
                  ),
                  child: Text(
                    status,
                    style: r
                        .text(context.texts.labelMedium)
                        .copyWith(color: color),
                  ),
                ),
              ],
            ),
            SizedBox(height: r.sp(10)),
            Text(question.text, style: r.text(context.texts.titleMedium)),
            SizedBox(height: r.sp(10)),
            if (answer != null && !correct)
              _AnswerLine(
                icon: Icons.close_rounded,
                color: palette.danger,
                label: 'Jawabanmu',
                value: _option(answer!),
              ),
            _AnswerLine(
              icon: Icons.check_rounded,
              color: palette.success,
              label: correct ? 'Jawabanmu' : 'Jawaban benar',
              value: _option(question.correctIndex),
            ),
            if (question.explanation.isNotEmpty) ...[
              SizedBox(height: r.sp(8)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(r.sp(12)),
                decoration: BoxDecoration(
                  color: palette.primarySoft,
                  borderRadius: BorderRadius.circular(r.sp(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: r.sp(18),
                      color: context.colors.primary,
                    ),
                    SizedBox(width: r.sp(8)),
                    Expanded(
                      child: Text(
                        question.explanation,
                        style: r.text(context.texts.bodySmall),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AnswerLine extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _AnswerLine({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: r.sp(18), color: color),
          SizedBox(width: r.sp(6)),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$label: ',
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(color: color, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              style: r.text(context.texts.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}
