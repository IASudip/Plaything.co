import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/controller/mode_pattern_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/pattern_appbar.dart';

class PatternModePage extends StatefulWidget {
  const PatternModePage({super.key});

  @override
  State<PatternModePage> createState() => _PatternModePageState();
}

class _PatternModePageState extends State<PatternModePage> {
  final ConnectingDeviceController _connectingDeviceController =
      Get.put(ConnectingDeviceController());
  final PatternModeController _patternModeController =
      Get.put(PatternModeController());

  double _strength = 110.0;
  int modeIndex = 1;

  @override
  void initState() {
    super.initState();

    _connectingDeviceController.onCharacteristicRead();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    List<PatternDetails> patternDetail = [
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 4]);
          _connectingDeviceController.sendData(byteData);
          modeIndex = 1;
          setState(() {});
        },
        image: ImagePath.shockWave,
        name: "Shock Wave",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 3]);
          _connectingDeviceController.sendData(byteData);
          modeIndex = 2;
          setState(() {});
        },
        image: ImagePath.lightningWave,
        name: "Lightning",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 5]);
          _connectingDeviceController.sendData(byteData);
          modeIndex = 3;
          setState(() {});
        },
        image: ImagePath.parkorWave,
        name: "Parkor",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 7]);
          _connectingDeviceController.sendData(byteData);
          modeIndex = 4;
          setState(() {});
        },
        image: ImagePath.bangBangWave,
        name: "Bang-Bang",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 6]);
          _connectingDeviceController.sendData(byteData);
          modeIndex = 5;
          setState(() {});
        },
        image: ImagePath.swingWave,
        name: "Swing",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x00, 9]);
          _connectingDeviceController.sendData(byteData);
          modeIndex = 6;
          setState(() {});
        },
        image: ImagePath.bungyWave,
        name: "Bungy",
      ),
    ];

    return Scaffold(
      appBar: const PatternAppBar(),
      bottomNavigationBar: PlayThingFooter(
        color: appTheme.red30003,
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: appTheme.gray80001,
        onPressed: () {
          Uint8List byteData = Uint8List.fromList([0x0, 255]);
          _connectingDeviceController.sendData(byteData);
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
                  height: 330.customHeight,
                  width: width,
                  margin: EdgeInsets.only(bottom: 30.0.customHeight),
                  child: LineChart(
                    LineChartData(
                        minX: 0,
                        maxX: 11,
                        minY: 0,
                        maxY: 11,
                        borderData: FlBorderData(show: false),
                        lineTouchData: const LineTouchData(enabled: false),
                        titlesData: const FlTitlesData(show: false),
                        gridData: const FlGridData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            preventCurveOverShooting: true,
                            isCurved: true,
                            curveSmoothness: 0.5,
                            dotData: const FlDotData(show: false),
                            isStrokeCapRound: true,
                            gradient: LinearGradient(
                              colors: [
                                appTheme.gray80001,
                                appTheme.gray600,
                              ],
                            ),
                            spots: List.generate(
                              _patternModeController
                                  .patternDesgn(modeIndex)
                                  .length,
                              (index) {
                                List<double> flspot = _patternModeController
                                    .patternDesgn(modeIndex)[index];
                                return FlSpot(flspot[0], flspot[1]);
                              },
                            ),
                          )
                        ]),
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
                        min: 110,
                        max: 113,
                        value: _strength,
                        onChanged: (value) {
                          _strength = value;
                          final Uint8List bytes =
                              Uint8List.fromList([0x0, _strength.toInt()]);
                          _connectingDeviceController.sendData(bytes);
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
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: patternDetail.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 16 / 9,
                      mainAxisExtent: height * 0.15.customHeight,
                      maxCrossAxisExtent: width * 0.4.customWidth,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: patternDetail[index].onTap,
                        child: Container(
                          height: 103.customHeight,
                          width: 103.customWidth,
                          margin: const EdgeInsets.all(20),
                          padding:
                              EdgeInsets.symmetric(vertical: 10.0.customHeight),
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
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Uint8List byteData = Uint8List.fromList([0x0, 255]);
    _connectingDeviceController.sendData(
      byteData,
    );
    super.dispose();
  }
}
