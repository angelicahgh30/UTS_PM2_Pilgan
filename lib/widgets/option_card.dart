import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

enum OptionState { idle, correct, wrong, dimmed }

class OptionCard extends StatelessWidget {
  final int index;
  final String text;
  final OptionState state;
  final VoidCallback? onTap;

  const OptionCard({
    super.key,
    required this.index,
    required this.text,
    this.state = OptionState.idle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final colors = context.colors;
    final letter = String.fromCharCode(65 + index);

    final (
      Color bg,
      Color border,
      Color badgeBg,
      Color badgeFg,
    ) = switch (state) {
      OptionState.correct => (
        palette.successSoft,
        palette.success,
        palette.success,
        Colors.white,
      ),
      OptionState.wrong => (
        palette.dangerSoft,
        palette.danger,
        palette.danger,
        Colors.white,
      ),
      _ => (
        colors.surface,
        palette.border,
        palette.primarySoft,
        colors.primary,
      ),
    };
    final radius = BorderRadius.circular(r.sp(14));

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(10)),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: state == OptionState.dimmed ? 0.55 : 1,
        child: Material(
          color: bg,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(
              color: border,
              width: state == OptionState.idle ? 1 : 1.8,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(r.sp(14)),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: r.sp(34),
                    height: r.sp(34),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(r.sp(10)),
                    ),
                    child: Text(
                      letter,
                      style: r
                          .text(context.texts.labelLarge)
                          .copyWith(color: badgeFg),
                    ),
                  ),
                  SizedBox(width: r.sp(12)),
                  Expanded(
                    child: Text(
                      text,
                      style: r
                          .text(context.texts.bodyLarge)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (state == OptionState.correct)
                    Icon(
                      Icons.check_circle_rounded,
                      color: palette.success,
                      size: r.sp(24),
                    ),
                  if (state == OptionState.wrong)
                    Icon(
                      Icons.cancel_rounded,
                      color: palette.danger,
                      size: r.sp(24),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
