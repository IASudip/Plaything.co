import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/neumorph_button.dart';

class ModeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ModeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: InkWell(
          onTap: () => Get.toNamed(AppRoute.setting),
          child: Padding(
            padding:
                EdgeInsets.only(left: 20.0.customWidth, top: 20.0.customHeight),
            child: SvgPicture.asset(
              ImagePath.splashScreenLogo,
              width: 24.68.customWidth,
              height: 35.customHeight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: 20.0.customHeight, right: 20.0.customWidth),
            child: NeumorphismButton(
              onTap: () => Get.toNamed(AppRoute.connectDevice),
              height: 40.customHeight,
              width: 40.customWidth,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0.adaptSize),
                child: SvgPicture.asset(
                  ImagePath.bluetooth,
                ),
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
