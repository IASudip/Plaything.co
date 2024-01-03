import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plaything/controller/mode_free_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';

class FreeModePage extends StatefulWidget {
  const FreeModePage({
    super.key,
  });

  @override
  State<FreeModePage> createState() => _FreeModePageState();
}

class _FreeModePageState extends State<FreeModePage> {
  final FreeModeController modeFreeController = Get.put(FreeModeController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Obx(() {
      return Scaffold(
        appBar: TitleAppBar(
          title: const Text('Free Mode'),
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
                          spots: List.generate(
                            modeFreeController.generatedRoute.length,
                            (index) {
                              var dataSpot =
                                  modeFreeController.generatedRoute[index];
                              return FlSpot(
                                dataSpot[0].toDouble(),
                                dataSpot[1].toDouble(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 63.customHeight,
                child: Container(
                  height: 420.customHeight,
                  width: width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0.customWidth,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0.customHeight,
                            horizontal: 10.0.customWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  modeFreeController.onLoopPressed(),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                fixedSize:
                                    Size(103.customWidth, 30.customHeight),
                                backgroundColor:
                                    !modeFreeController.isLoopSelected.value
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
                              onPressed: () =>
                                  modeFreeController.onFloatPressed(),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                fixedSize:
                                    Size(103.customWidth, 30.customHeight),
                                backgroundColor:
                                    !modeFreeController.isFloatSelected.value
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
                              onPressed: () => modeFreeController.onSave(),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: appTheme.orange50,
                                padding: EdgeInsets.zero,
                                fixedSize:
                                    Size(103.customWidth, 30.customHeight),
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
                        onPanStart: (details) =>
                            modeFreeController.onDragStart(details),
                        onPanEnd: (DragEndDetails details) =>
                            modeFreeController.onDragEnd(),
                        onPanUpdate: (DragUpdateDetails details) =>
                            modeFreeController.onDragUpdate(
                          details,
                          height,
                        ),
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
                                top: modeFreeController.top.value,
                                left: modeFreeController.left.value,
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
    });
  }
}
