import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class MusicModeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;
  const MusicModeAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
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
        title: const Text('Music'),
        bottom: TabBar(
          isScrollable: true,
          controller: controller,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(
            horizontal: 16.customWidth,
            vertical: 10.customHeight,
          ),
          indicator: BoxDecoration(
            color: appTheme.orange50,
            borderRadius: BorderRadius.circular(30.0.customWidth),
            border: Border.all(color: appTheme.orange50),
          ),
          splashBorderRadius: BorderRadius.circular(30.0.customWidth),
          labelColor: appTheme.gray80001,
          labelStyle: theme.textTheme.labelMedium,
          tabs: [
            Tab(
              child: Container(
                height: 30.customHeight,
                width: 103.customWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0.customWidth),
                  border: Border.all(
                    width: 1.0,
                    color: appTheme.orange50,
                  ),
                ),
                child: const Text('My Library'),
              ),
            ),
            Tab(
              child: Container(
                height: 30.customHeight,
                width: 103.customWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    100.0.customWidth,
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: appTheme.orange50,
                  ),
                ),
                child: const Text('Playlist'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(110.customHeight);
}
