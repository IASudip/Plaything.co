import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool automaticallyImplyLeading;
  const TitleAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
            height: 25.customHeight,
            width: 25.customWidth,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              ImagePath.backArrow,
              height: 19.customHeight,
              width: 11.customWidth,
            ),
          ),
        ),
        title: title,
      ),
    );
  }
}
