import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class AdaptiveTwoPane extends StatelessWidget {
  final Widget first;
  final Widget second;
  final int firstFlex;
  final int secondFlex;
  final CrossAxisAlignment alignment;

  const AdaptiveTwoPane({
    super.key,
    required this.first,
    required this.second,
    this.firstFlex = 1,
    this.secondFlex = 1,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    if (r.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          first,
          SizedBox(height: r.sp(20)),
          second,
        ],
      );
    }

    return Row(
      crossAxisAlignment: alignment,
      children: [
        Expanded(flex: firstFlex, child: first),
        SizedBox(width: r.sp(28)),
        Expanded(flex: secondFlex, child: second),
      ],
    );
  }
}
