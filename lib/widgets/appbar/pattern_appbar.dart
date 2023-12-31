import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/global.dart' as globals;

class PatternAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PatternAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  State<PatternAppBar> createState() => _PatternAppBarState();
}

class _PatternAppBarState extends State<PatternAppBar> {
  final ConnectingDeviceController _connectingDeviceController =
      Get.put(ConnectingDeviceController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PreferredSize(
        preferredSize: widget.preferredSize,
        child: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Container(
              height: 19.customHeight,
              width: 15.customWidth,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                ImagePath.backArrow,
                height: 19.customHeight,
                width: 11.customWidth,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.customWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall!.color,
                      fontSize: theme.textTheme.bodySmall!.fontSize,
                      fontWeight: theme.textTheme.titleMedium!.fontWeight,
                      fontFamily: theme.textTheme.bodySmall!.fontFamily,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: SvgPicture.asset(
                          width: 23.0.customWidth,
                          height: 10.0.customHeight,
                          ImagePath.battery,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 5.0.customWidth,
                        ),
                      ),
                      TextSpan(
                        text:
                            "${_connectingDeviceController.batteryLevel.toString()}%",
                        style: TextStyle(
                          color: theme.textTheme.bodySmall!.color,
                          fontSize: theme.textTheme.labelMedium!.fontSize,
                          fontWeight: theme.textTheme.labelMedium!.fontWeight,
                          fontFamily: theme.textTheme.bodySmall!.fontFamily,
                        ),
                      )
                    ]),
                  ),
                  Container(
                    width: 70.customWidth,
                    height: 15.customHeight,
                    padding: EdgeInsets.symmetric(horizontal: 8.0.customWidth),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: appTheme.red20002,
                    ),
                    child: Text(
                      globals.deviceState,
                      style: TextStyle(
                        color: theme.textTheme.bodySmall!.color,
                        fontSize: theme.textTheme.bodySmall!.fontSize,
                        fontWeight: theme.textTheme.titleMedium!.fontWeight,
                        fontFamily: theme.textTheme.bodySmall!.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
          title: const Text('Pattern'),
        ),
      );
    });
  }
}
