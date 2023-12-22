import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class PlayThingFooter extends StatelessWidget {
  final Color color;
  const PlayThingFooter({super.key, this.color = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 55.customHeight,
      color: color,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Plaything.co'),
        ],
      ),
    );
  }
}
