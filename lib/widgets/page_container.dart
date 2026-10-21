import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  const PageContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? r.maxContentWidth),
          child: Padding(
            padding:
                padding ??
                EdgeInsets.fromLTRB(
                  r.pagePadding,
                  r.sp(12),
                  r.pagePadding,
                  r.sp(24),
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}
