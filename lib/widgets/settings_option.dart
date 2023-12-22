import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class SettingsOption extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Widget? trailing;
  final bool divider;
  const SettingsOption({
    required this.onTap,
    super.key,
    required this.title,
    this.divider = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          titleTextStyle: theme.textTheme.bodyMedium,
          trailing: trailing,
        ),
        Visibility(
          visible: divider,
          child: const Divider(),
        ),
      ],
    );
  }
}
