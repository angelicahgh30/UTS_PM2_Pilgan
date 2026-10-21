import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class NavyHeaderLayout extends StatelessWidget {
  final double headerHeight;
  final Widget child;
  final double? maxWidth;

  const NavyHeaderLayout({
    super.key,
    required this.headerHeight,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final top = MediaQuery.paddingOf(context).top;

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: top + r.sp(headerHeight),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(r.sp(32)),
                ),
              ),
              child: CustomPaint(painter: _DotsPainter()),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? r.maxContentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  r.pagePadding,
                  top + r.sp(16),
                  r.pagePadding,
                  r.sp(24),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.07);
    const gap = 18.0;
    for (var x = size.width - gap * 7; x < size.width; x += gap) {
      for (var y = gap; y < size.height * 0.6; y += gap) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotsPainter oldDelegate) => false;
}

class NavyTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const NavyTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(24)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: r.text(context.texts.headlineMedium).onNavy),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: r.text(context.texts.bodyMedium).onNavyMuted,
                  ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

extension OnNavy on TextStyle {
  TextStyle get onNavy => copyWith(color: Colors.white);
  TextStyle get onNavyMuted =>
      copyWith(color: Colors.white.withValues(alpha: 0.72));
}
