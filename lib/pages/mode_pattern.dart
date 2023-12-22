import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/pattern_appbar.dart';
import 'package:plaything/core/global.dart' as globals;

class PatternModePage extends StatefulWidget {
  const PatternModePage({super.key});

  @override
  State<PatternModePage> createState() => _PatternModePageState();
}

class _PatternModePageState extends State<PatternModePage> {
  double _speed = 1.0;
  double _strength = 0.0;

  final ConnectingDeviceController _connectingDeviceController =
      ConnectingDeviceController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    List<PatternDetails> patternDetail = [
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 3]);

          _connectingDeviceController.sendData(
              globals.writeCharacteristic, byteData);
        },
        image: ImagePath.shockWave,
        name: "Shock Wave",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 4]);

          _connectingDeviceController.sendData(
              globals.writeCharacteristic, byteData);
        },
        image: ImagePath.lightningWave,
        name: "Lightning",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 5]);

          _connectingDeviceController.sendData(
              globals.writeCharacteristic, byteData);
        },
        image: ImagePath.parkorWave,
        name: "Parkor",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 7]);

          _connectingDeviceController.sendData(
              globals.writeCharacteristic, byteData);
        },
        image: ImagePath.bangBangWave,
        name: "Bang-Bang",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 8]);

          _connectingDeviceController.sendData(
              globals.writeCharacteristic, byteData);
        },
        image: ImagePath.swingWave,
        name: "Swing",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 12]);

          _connectingDeviceController.sendData(
              globals.writeCharacteristic, byteData);
        },
        image: ImagePath.bungyWave,
        name: "Bungy",
      ),
    ];

    return Scaffold(
      appBar: PatternAppBar(),
      bottomNavigationBar: PlayThingFooter(
        color: appTheme.red30003,
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: appTheme.gray80001,
        onPressed: () {
          Uint8List byteData = Uint8List.fromList([0x0, 0x0]);
          _connectingDeviceController.sendData(
              globals.writeCharacteristic, byteData);
        },
        child: Icon(
          Icons.stop_rounded,
          color: appTheme.deepOrange20001,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Container(
        width: width,
        height: height,
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
            Align(
              alignment: const Alignment(0, -0.85),
              child: Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  ImagePath.splashScreenLogo,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 209.customHeight,
                  width: width,
                  margin: EdgeInsets.only(bottom: 30.0.customHeight),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                Container(
                  height: 48.customHeight,
                  width: width,
                  margin: EdgeInsets.symmetric(
                    vertical: 25.0.customHeight,
                    horizontal: 10.0.customWidth,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0.customWidth,
                          vertical: 6.0.customHeight,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Weak',
                              style: theme.textTheme.bodySmall,
                            ),
                            Text(
                              'Strong',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        value: _strength,
                        onChanged: (value) {
                          _strength = value;
                          debugPrint(_strength.toString());
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80.customHeight,
                  width: width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0.customWidth,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Speed',
                        style: theme.textTheme.titleSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            5,
                            (index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.customWidth,
                                      vertical: 7.0.customHeight),
                                  child: Text("${index + 1}"),
                                )),
                      ),
                      Slider(
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        value: _speed,
                        onChanged: (value) {
                          _speed = value.roundToDouble();
                          debugPrint(_speed.toString());
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 250.customHeight,
                  width: width,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: patternDetail.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 1.0,
                        mainAxisExtent: 120,
                        maxCrossAxisExtent: 120,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: patternDetail[index].onTap,
                          child: Container(
                            height: 103.customHeight,
                            width: 103.customWidth,
                            margin: const EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0.customHeight),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0XFFE1A990),
                                    appTheme.red30001,
                                  ]),
                              borderRadius:
                                  BorderRadius.circular(20.0.customWidth),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SvgPicture.asset(
                                    height: 47.customHeight,
                                    width: 101.customWidth,
                                    fit: BoxFit.fitWidth,
                                    patternDetail[index].image,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      patternDetail[index].name,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PatternDetails {
  final VoidCallback onTap;
  final String image;
  final String name;

  PatternDetails({
    required this.onTap,
    required this.image,
    required this.name,
  });
}
