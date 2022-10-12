import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sample_bloc/src/theme/theme.dart';

class SliverWithMaxConstraints extends StatelessWidget {
  final double maxWidth;
  final Widget sliver;

  const SliverWithMaxConstraints({
    super.key,
    required this.sliver,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SliverPadding(
      padding: _calculatePaddingsOfWidth(maxWidth, screenWidth),
      sliver: sliver,
    );
  }

  EdgeInsets _calculatePaddingsOfWidth(double maxWidth, double screenWidth) {
    double additionalSize = 0;

    return EdgeInsets.symmetric(
      horizontal: max((screenWidth - maxWidth - additionalSize) / 2, 0) +
          defaultListPaddingValue,
      vertical: defaultListPaddingValue,
    );
  }
}
