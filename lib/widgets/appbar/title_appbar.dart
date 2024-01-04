import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';

class TitleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final bool automaticallyImplyLeading;
  const TitleAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = false,
  });

  @override
  State<TitleAppBar> createState() => _TitleAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _TitleAppBarState extends State<TitleAppBar> {
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
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
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
        title: widget.title,
        actions: [
          Row(
            children: [
              SvgPicture.asset(ImagePath.battery),
              Padding(
                padding: EdgeInsets.only(
                  right: 20.customWidth,
                  left: 5.customWidth,
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
      ),
    );
  }
}
