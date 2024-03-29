import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class PlaythingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Widget child;
  const PlaythingButton({
    super.key,
    this.label = 'Plaything.co',
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          width * 0.9.customWidth,
          47.customHeight,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0.customHeight,
          horizontal: 15.0.customWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: child,
    );
  }
}
