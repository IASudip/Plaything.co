import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';

class MusicModeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MusicModeAppBar({super.key});

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
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(
              horizontal: 20.customWidth, vertical: 8.customHeight),
          indicator: BoxDecoration(
            // color: Colors.amber,
            borderRadius: BorderRadius.circular(100.0.customWidth),
            border: Border.all(color: appTheme.orange50),
          ),
          labelColor: appTheme.gray80001,
          labelStyle: theme.textTheme.labelMedium,
          tabs: const [
            Tab(
              text: 'My Library',
            ),
            Tab(
              text: 'Playlist',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(110.customHeight);
}
