import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class RippleContainer extends StatelessWidget {
  final double radius;
  final double animationValue;
  const RippleContainer(
      {super.key, required this.radius, required this.animationValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * animationValue,
      width: radius * animationValue,
      decoration: BoxDecoration(
        color: appTheme.gray80001.withOpacity(animationValue * 0.1),
        shape: BoxShape.circle,
      ),
    );
  }
}
