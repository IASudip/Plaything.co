import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';

class PatternModeController extends GetxController {
  // final ConnectingDeviceController _connectingDeviceController =
  //     Get.put(ConnectingDeviceController());

  List<List<double>> patternDesgn(int mode) {
    switch (mode) {
      case 1:
        {
          return const [
            [0, 6],
            [1, 10],
            [3, 1],
            [5, 10],
            [7, 1],
            [9, 10],
            [11, 1],
          ];
        }

      case 2:
        {
          return const [
            [0, 3],
            [5, 9.5],
            [11, 3],
          ];
        }

      case 3:
        {
          return const [
            [0, 0],
            [1, 2],
            [2, 0],
            [4, 9],
            [6, 1],
            [7.5, 4],
            [9, 1],
            [10.5, 7],
            [11, 5],
          ];
        }

      case 4:
        {
          return const [
            [0, 1],
            [0.5, 8],
            [1.5, 1],
            [2.5, 4],
            [4, 1],
            [6.5, 10.5],
            [9, 1],
            [10.5, 7],
            [11, 5],
          ];
        }

      case 5:
        {
          return const [
            [0, 1],
            [1.5, 10],
            [2.5, 6],
            [3.5, 8],
            [4.5, 6],
            [5.5, 9],
            [6, 4],
            [7, 8],
            [8, 5],
            [9.5, 7.5],
            [11, 5]
          ];
        }

      case 6:
        {
          return const [
            [0, 0],
            [1, 5],
            [2, 0],
            [4, 8.5],
            [6, 1],
            [7.5, 10],
            [9, 1],
            [10.5, 7],
            [11, 5],
          ];
        }

      case 7:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }

      case 8:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }

      case 9:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }

      case 10:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }

      case 11:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }

      case 12:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }

      case 13:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }

      default:
        {
          return const [
            [0, 6],
            [1, 3],
            [3, 5],
            [5, 7],
            [7, 2],
            [9, 5],
            [11, 10],
          ];
        }
    }
  }
}

class PatternDetails {
  final VoidCallback onTap;
  final String image;
  final String name;
  final List<FlSpot>? spots;

  PatternDetails(
      {required this.onTap,
      required this.image,
      required this.name,
      this.spots});
}
