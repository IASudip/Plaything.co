import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class NeumorphismButton extends StatefulWidget {
  final VoidCallback? onTap;

  final double height;
  final double width;
  final Widget child;
  final double elevation;
  const NeumorphismButton({
    Key? key,
    required this.onTap,
    this.height = 65,
    this.width = 65,
    this.elevation = 5,
    required this.child,
  }) : super(key: key);

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        widget.height.customHeight,
      ),
      splashColor: Colors.white,
      onTap: widget.onTap,
      child: Container(
        height: widget.height.customHeight,
        width: widget.width.customWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                appTheme.gray80001,
                appTheme.gray600,
              ],
            ),
            boxShadow: [
              BoxShadow(
                  color: appTheme.gray70001,
                  spreadRadius: 0.1.fSize,
                  blurRadius: 10),
            ]),
        child: Container(
          height: (widget.height - 5).customHeight,
          width: (widget.width - 5).customWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                appTheme.gray600,
                appTheme.gray80001,
              ],
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
