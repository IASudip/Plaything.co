import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/utlis/shared_pref.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreeModePage extends StatefulWidget {
  final BluetoothCharacteristic? bluetoothCharacteristic;
  const FreeModePage({
    super.key,
    this.bluetoothCharacteristic,
  });

  @override
  State<FreeModePage> createState() => _FreeModePageState();
}

class _FreeModePageState extends State<FreeModePage> {
  bool _isLoopSelected = true;
  bool _isFloatSelected = false;

  double left = 10.0.customWidth;
  double top = 290.0.customHeight;
  final double _intensityValue = 0.0;
  List<List<int>> freeModeRoute = [];
  List<List<int>> generatedRoute = [];

  final ConnectingDeviceController _connectingDeviceController =
      Get.put(ConnectingDeviceController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const TitleAppBar(
        title: Text('Free Mode'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const PlayThingFooter(
        color: Colors.transparent,
      ),
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
            Positioned(
              top: 30.customHeight,
              child: SizedBox(
                height: 209.customHeight,
                width: width,
                child: LineChart(
                  duration: const Duration(seconds: 60),
                  curve: Curves.easeIn,
                  LineChartData(
                      minX: 2.0,
                      maxX: 150,
                      minY: 0.0,
                      maxY: 16.0,
                      borderData: FlBorderData(show: false),
                      lineTouchData: const LineTouchData(enabled: false),
                      titlesData: const FlTitlesData(show: false),
                      gridData: const FlGridData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          dotData: const FlDotData(show: false),
                          isStrokeCapRound: true,
                          gradient: LinearGradient(
                            colors: [
                              appTheme.gray80001,
                              appTheme.gray600,
                            ],
                          ),
                          spots: List.generate(generatedRoute.length, (index) {
                            var dataSpot = generatedRoute[index];

                            return FlSpot(
                              dataSpot[0].toDouble(),
                              dataSpot[1].toDouble(),
                            );
                          }),
                        ),
                      ]),
                ),
              ),
            ),
            Positioned(
              bottom: 63.customHeight,
              child: Container(
                height: 470.customHeight,
                width: width,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0.customWidth,
                ),
                child: Column(
                  children: [
                    FreeModeSlider(
                      value: _intensityValue,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.customHeight,
                          horizontal: 10.0.customWidth),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _isLoopSelected = !_isLoopSelected;
                              _isFloatSelected = !_isFloatSelected;
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              fixedSize: Size(103.customWidth, 30.customHeight),
                              backgroundColor: !_isLoopSelected
                                  ? Colors.transparent
                                  : Colors.white,
                              side: const BorderSide(color: Colors.white),
                            ),
                            child: Text(
                              "Loop",
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _isLoopSelected = !_isLoopSelected;
                              _isFloatSelected = !_isFloatSelected;
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              fixedSize: Size(103.customWidth, 30.customHeight),
                              backgroundColor: !_isFloatSelected
                                  ? Colors.transparent
                                  : Colors.white,
                              side: const BorderSide(color: Colors.white),
                            ),
                            child: Text(
                              "Float",
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              debugPrint("${freeModeRoute.runtimeType}");
                              if (freeModeRoute.isNotEmpty) {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                String jsonString = jsonEncode(freeModeRoute);
                                pref.setString(
                                    PrefString.loopRouteData, jsonString);
                                String? savedLoopData =
                                    pref.getString(PrefString.loopRouteData);
                                debugPrint('$savedLoopData');
                              } else {
                                debugPrint('Loop is empty!');
                                return;
                              }
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: appTheme.orange50,
                              padding: EdgeInsets.zero,
                              fixedSize: Size(103.customWidth, 30.customHeight),
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(color: Colors.white),
                            ),
                            child: Text(
                              "Save",
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onPanStart: (details) {
                        freeModeRoute.clear();
                      },
                      onPanEnd: (details) async {
                        debugPrint(
                            "-------::::::On Loop started:::::---------");

                        while (_isLoopSelected) {
                          for (var i = 0; i < freeModeRoute.length; i++) {
                            final byteData =
                                Uint8List.fromList(freeModeRoute[i]);
                            await _connectingDeviceController.sendData(
                              widget.bluetoothCharacteristic,
                              byteData,
                            );
                          }
                        }
                      },
                      onPanUpdate: (details) {
                        left = max(0, left + details.delta.dx);
                        top = max(0, top + details.delta.dy);
                        debugPrint('--->>>Top::$top<<<----');

                        setState(() {});
                        if (top > 0) {
                          int yAxisValue =
                              (201 + (1 - top / height.customHeight) * 19)
                                  .toInt();

                          List<int> getPoints = [
                            (yAxisValue >> 8) & 0xff,
                            yAxisValue & 0xff
                          ];

                          final byteData = Uint8List.fromList(getPoints);
                          _connectingDeviceController.sendData(
                            widget.bluetoothCharacteristic,
                            byteData,
                          );

                          // Adding data for loop mode
                          freeModeRoute.add(getPoints);

                          // generating route
                          if (generatedRoute.isNotEmpty) {
                            generatedRoute.clear();
                          } else {
                            generatedRoute = generateList(freeModeRoute.length);
                          }

                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 350.customHeight,
                        width: 350.customWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            width: 1.customWidth,
                            color: appTheme.orange50,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: top,
                              left: left,
                              child: Container(
                                height: 25.customHeight,
                                width: 25.customWidth,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1.0,
                                    color: appTheme.orange50,
                                  ),
                                  color: appTheme.deepOrange20001,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              fit: BoxFit.cover,
                              ImagePath.freeModePadLines,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<List<int>> generateList(int numberOfLists) {
    List<List<int>> result = [];

    int previousValue = 0;

    for (int i = 0; i < numberOfLists; i++) {
      int randomValue = ((Random().nextInt(150) + 20) ~/ 10).toInt();
      int firstValue = previousValue + 2;
      List<int> innerList = [firstValue, randomValue];
      result.add(innerList);

      previousValue = firstValue;
    }

    return result;
  }
}

// ignore: must_be_immutable
class FreeModeSlider extends StatefulWidget {
  double value;
  FreeModeSlider({super.key, required this.value});

  @override
  State<FreeModeSlider> createState() => _FreeModeSliderState();
}

class _FreeModeSliderState extends State<FreeModeSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.customWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Slow',
                style: theme.textTheme.bodySmall,
              ),
              Text(
                'Fast',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 15.0.customHeight, horizontal: 5.0.customWidth),
          child: Slider(
            value: widget.value,
            onChanged: (double v) {
              widget.value = v;
              setState(() {});
              debugPrint(v.toString());
            },
          ),
        ),
      ],
    );
  }
}
