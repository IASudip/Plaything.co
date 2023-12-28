import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LongDistanceModePage extends StatefulWidget {
  const LongDistanceModePage({super.key});

  @override
  State<LongDistanceModePage> createState() => _LongDistanceModePageState();
}

class _LongDistanceModePageState extends State<LongDistanceModePage> {
  double onChangeStart = 0.0;
  double onChangeEnd = 0.0;
  double onChange = 0.0;

  final ConnectingDeviceController connectingDeviceController =
      Get.put(ConnectingDeviceController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: TitleAppBar(
        title: const Text('Long Distance'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const PlayThingFooter(),
      body: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.5, 0),
            end: const Alignment(0.5, 1),
            colors: [
              appTheme.gray400,
              appTheme.red30003,
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  ImagePath.splashScreenLogo,
                ),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                ImagePath.vibrationProgressbar,
              ),
            ),
            Center(
              child: SizedBox(
                width: 166.48.customWidth,
                height: 166.48.customHeight,
                child: SleekCircularSlider(
                  min: 201,
                  max: 220,
                  initialValue: 204,
                  appearance: CircularSliderAppearance(
                    startAngle: 90,
                    angleRange: 360,
                    customWidths: CustomSliderWidths(
                      trackWidth: 30.0.customWidth,
                      handlerSize: 13.0.customWidth,
                      progressBarWidth: 30.0.customWidth,
                    ),
                    customColors: CustomSliderColors(
                      dotColor: appTheme.gray800,
                      hideShadow: true,
                      trackColors: [
                        const Color(0xff1F2124),
                        appTheme.gray90001,
                      ],
                      trackColor: appTheme.gray90001,
                      progressBarColors: [
                        appTheme.gray70001,
                        appTheme.gray800,
                      ],
                    ),
                  ),
                  onChangeStart: (double value) {
                    debugPrint("$value");
                    setState(() {});
                  },
                  onChangeEnd: (double value) {
                    debugPrint("$value");
                    setState(() {});
                  },
                  onChange: (double value) {
                    Uint8List byteData =
                        Uint8List.fromList([0x0, value.toInt()]);
                    connectingDeviceController.sendData(
                      byteData,
                    );
                    setState(() {});
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
