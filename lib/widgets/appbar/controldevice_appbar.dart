import 'package:flutter/material.dart';

class ConnectDeviceAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget title;
  const ConnectDeviceAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        automaticallyImplyLeading: false,
        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
