import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class AdaptiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double minItemWidth;

  const AdaptiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 320,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final gap = r.sp(12);

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / minItemWidth).floor().clamp(
          1,
          2,
        );
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}
