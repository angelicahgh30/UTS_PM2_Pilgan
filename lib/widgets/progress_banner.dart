import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class ProgressBanner extends StatelessWidget {
  final int done;
  final int total;

  const ProgressBanner({super.key, required this.done, required this.total});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final remaining = total - done;

    return Container(
      padding: EdgeInsets.all(r.sp(18)),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(r.sp(20)),
        border: Border.all(color: palette.border),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: r.sp(20),
            offset: Offset(0, r.sp(8)),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progres belajar',
                  style: r
                      .text(context.texts.labelMedium)
                      .copyWith(color: palette.muted),
                ),
                SizedBox(height: r.sp(2)),
                Text.rich(
                  TextSpan(
                    text: '$done',
                    children: [
                      TextSpan(
                        text: ' / $total bab',
                        style: TextStyle(color: palette.muted),
                      ),
                    ],
                  ),
                  style: r.text(context.texts.headlineMedium),
                ),
                SizedBox(height: r.sp(10)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(r.sp(8)),
                  child: LinearProgressIndicator(
                    value: total == 0 ? 0 : done / total,
                    minHeight: r.sp(8),
                    color: palette.accent,
                    backgroundColor: palette.accentSoft,
                  ),
                ),
                SizedBox(height: r.sp(8)),
                Text(
                  remaining == 0
                      ? 'Semua bab sudah kamu selesaikan.'
                      : 'Tinggal $remaining bab lagi yang belum dikerjakan.',
                  style: r
                      .text(context.texts.bodySmall)
                      .copyWith(color: palette.muted),
                ),
              ],
            ),
          ),
          SizedBox(width: r.sp(12)),
          SvgPicture.asset('assets/images/trophy.svg', width: r.sp(80)),
        ],
      ),
    );
  }
}
