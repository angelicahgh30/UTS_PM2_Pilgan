import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

enum AppButtonVariant { filled, outlined, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool expand;
  final Color? color;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.filled,
    this.expand = true,
    this.color,
  });

  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expand = true,
    this.color,
  }) : variant = AppButtonVariant.outlined;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, r.sp(52))),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: r.sp(20)),
      ),
      textStyle: WidgetStatePropertyAll(
        r.text(Theme.of(context).textTheme.labelLarge),
      ),
      backgroundColor: color != null && variant == AppButtonVariant.filled
          ? WidgetStatePropertyAll(color)
          : null,
      foregroundColor: color != null && variant != AppButtonVariant.filled
          ? WidgetStatePropertyAll(color)
          : null,
      side: color != null && variant == AppButtonVariant.outlined
          ? WidgetStatePropertyAll(BorderSide(color: color!, width: 1.5))
          : null,
    );

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: r.sp(20)),
          SizedBox(width: r.sp(8)),
        ],
        Flexible(
          child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );

    final button = switch (variant) {
      AppButtonVariant.filled => FilledButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
