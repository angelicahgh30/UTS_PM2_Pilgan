import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'app_button.dart';
import 'info_chip.dart';

enum FeedbackType { correct, wrong, timeout }

class FeedbackPanel extends StatelessWidget {
  final FeedbackType type;
  final int combo;
  final String correctAnswer;
  final String explanation;
  final String buttonLabel;
  final VoidCallback onNext;

  const FeedbackPanel({
    super.key,
    required this.type,
    required this.combo,
    required this.correctAnswer,
    required this.explanation,
    required this.buttonLabel,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;

    final (
      Color color,
      Color soft,
      IconData icon,
      String title,
    ) = switch (type) {
      FeedbackType.correct => (
        palette.success,
        palette.successSoft,
        Icons.check_circle_rounded,
        'Jawaban kamu benar!',
      ),
      FeedbackType.wrong => (
        palette.danger,
        palette.dangerSoft,
        Icons.cancel_rounded,
        'Belum tepat',
      ),
      FeedbackType.timeout => (
        palette.warning,
        palette.accentSoft,
        Icons.timer_off_rounded,
        'Waktu habis',
      ),
    };

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        r.pagePadding,
        r.sp(18),
        r.pagePadding,
        r.sp(14),
      ),
      decoration: BoxDecoration(
        color: soft,
        border: Border(top: BorderSide(color: color, width: 2)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: r.sp(26)),
                SizedBox(width: r.sp(8)),
                Expanded(
                  child: Text(
                    title,
                    style: r
                        .text(context.texts.titleLarge)
                        .copyWith(color: color),
                  ),
                ),
                if (type == FeedbackType.correct && combo >= 2)
                  InfoChip(
                    icon: Icons.local_fire_department_rounded,
                    label: 'Combo ${combo}x',
                    color: palette.warning,
                    background: palette.accentSoft,
                  ),
              ],
            ),
            if (type != FeedbackType.correct)
              Padding(
                padding: EdgeInsets.only(top: r.sp(6)),
                child: Text.rich(
                  TextSpan(
                    text: 'Jawaban benar: ',
                    children: [
                      TextSpan(
                        text: correctAnswer,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  style: r.text(context.texts.bodyMedium),
                ),
              ),
            if (explanation.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: r.sp(6)),
                child: Text(
                  explanation,
                  style: r
                      .text(context.texts.bodyMedium)
                      .copyWith(color: palette.muted),
                ),
              ),
            SizedBox(height: r.sp(14)),
            AppButton(label: buttonLabel, color: color, onPressed: onNext),
          ],
        ),
      ),
    );
  }
}
