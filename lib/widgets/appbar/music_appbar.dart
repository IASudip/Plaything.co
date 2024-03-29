import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';

class MusicModeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController? controller;
  const MusicModeAppBar({super.key, required this.controller});

  @override
  State<MusicModeAppBar> createState() => _MusicModeAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(110.customHeight);
}

class _MusicModeAppBarState extends State<MusicModeAppBar> {
  final ConnectingDeviceController connectingDeviceController =
      Get.put(ConnectingDeviceController());

  @override
  void initState() {
    super.initState();
    connectingDeviceController.onCharacteristicRead();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
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
        actions: [
          Row(
            children: [
              SvgPicture.asset(ImagePath.battery),
              Padding(
                padding: EdgeInsets.only(
                  right: 20.customWidth,
                  left: 10.customWidth,
                ),
                child: Obx(() {
                  return Text(
                    "${connectingDeviceController.batteryLevel.value.toString()} %",
                    style: TextStyle(
                      color: theme.textTheme.bodySmall!.color,
                      fontSize: theme.textTheme.labelMedium!.fontSize,
                      fontWeight: theme.textTheme.labelMedium!.fontWeight,
                      fontFamily: theme.textTheme.bodySmall!.fontFamily,
                    ),
                  );
                }),
              ),
            ],
          )
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: widget.controller,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.symmetric(
            vertical: 8.adaptSize,
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
                    30.0.customWidth,
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
}
