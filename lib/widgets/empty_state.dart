import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'app_button.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.sp(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/empty.svg',
            width: (r.size.shortestSide * 0.45).clamp(140.0, 220.0),
          ),
          SizedBox(height: r.sp(16)),
          Text(
            title,
            textAlign: TextAlign.center,
            style: r.text(context.texts.titleLarge),
          ),
          SizedBox(height: r.sp(6)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: r
                .text(context.texts.bodyMedium)
                .copyWith(color: context.palette.muted),
          ),
          if (actionLabel != null) ...[
            SizedBox(height: r.sp(18)),
            AppButton(label: actionLabel!, onPressed: onAction, expand: false),
          ],
        ],
      ),
    );
  }
}
