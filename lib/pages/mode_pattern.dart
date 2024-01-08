import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
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

  double _strength = 110.0;

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
        },
        image: ImagePath.shockWave,
        name: "Shock Wave",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 3]);

          _connectingDeviceController.sendData(byteData);
        },
        image: ImagePath.lightningWave,
        name: "Lightning",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 5]);

          _connectingDeviceController.sendData(byteData);
        },
        image: ImagePath.parkorWave,
        name: "Parkor",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 7]);

          _connectingDeviceController.sendData(byteData);
        },
        image: ImagePath.bangBangWave,
        name: "Bang-Bang",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x0, 6]);
          _connectingDeviceController.sendData(byteData);
        },
        image: ImagePath.swingWave,
        name: "Swing",
      ),
      PatternDetails(
        onTap: () {
          Uint8List byteData = Uint8List.fromList([0x00, 9]);
          _connectingDeviceController.sendData(byteData);
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
                            spots: patternDesign(6),
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
                          debugPrint(_strength.toString());
                          final Uint8List bytes =
                              Uint8List.fromList([0x0, _strength.toInt()]);
                          _connectingDeviceController.sendData(bytes);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                /* Container(
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
                        min: 195.0,
                        max: 200.0,
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
                ),*/
                SizedBox(
                  height: 250.customHeight,
                  width: width,
                  child: GridView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
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

  List<FlSpot> patternDesign(int mode) {
    switch (mode) {
      case 1:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 10),
            FlSpot(3, 1),
            FlSpot(5, 10),
            FlSpot(7, 1),
            FlSpot(9, 10),
            FlSpot(11, 1),
          ];
        }

      case 2:
        {
          return const [
            FlSpot(0, 3),
            FlSpot(5.5, 9.5),
            FlSpot(11, 3),
          ];
        }

      case 3:
        {
          return const [
            FlSpot(0, 0),
            FlSpot(1, 2),
            FlSpot(2, 0),
            FlSpot(4, 9),
            FlSpot(6, 1),
            FlSpot(7.5, 4),
            FlSpot(9, 1),
            FlSpot(10.5, 7),
            FlSpot(11, 5),
          ];
        }

      case 4:
        {
          return const [
            FlSpot(0, 1),
            FlSpot(0.5, 8),
            FlSpot(1.5, 1),
            FlSpot(2.5, 4),
            FlSpot(4, 1),
            FlSpot(6.5, 10.5),
            FlSpot(9, 1),
            FlSpot(10.5, 7),
            FlSpot(11, 5),
          ];
        }

      case 5:
        {
          return const [
            FlSpot(0, 1),
            FlSpot(1.5, 10),
            FlSpot(2.5, 6),
            FlSpot(3.5, 8),
            FlSpot(4.5, 6),
            FlSpot(5.5, 9),
            FlSpot(6, 4),
            FlSpot(7, 8),
            FlSpot(8, 5),
            FlSpot(9.5, 7.5),
            FlSpot(11, 5)
          ];
        }

      case 6:
        {
          return const [
            FlSpot(0, 0),
            FlSpot(1, 5),
            FlSpot(2, 0),
            FlSpot(4, 8.5),
            FlSpot(6, 1),
            FlSpot(7.5, 10),
            FlSpot(9, 1),
            FlSpot(10.5, 7),
            FlSpot(11, 5),
          ];
        }

      case 7:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }

      case 8:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }

      case 9:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }

      case 10:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }

      case 11:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }

      case 12:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }

      case 13:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }

      default:
        {
          return const [
            FlSpot(0, 6),
            FlSpot(1, 3),
            FlSpot(3, 5),
            FlSpot(5, 7),
            FlSpot(7, 2),
            FlSpot(9, 5),
            FlSpot(11, 10),
          ];
        }
    }
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
