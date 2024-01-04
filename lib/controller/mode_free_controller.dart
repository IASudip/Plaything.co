import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/utlis/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connecting_device_controller.dart';

class FreeModeController extends GetxController {
  final ConnectingDeviceController _connectingDeviceController =
      Get.put(ConnectingDeviceController());
  RxBool isLoopSelected = true.obs;
  RxBool isFloatSelected = false.obs;

  RxDouble left = 10.0.customWidth.obs;
  RxDouble top = 290.0.customHeight.obs;
  final double intensityValue = 0.0;
  List<List<int>> freeModeRoute = [];
  List<List<int>> generatedRoute = [];

  onLoopPressed() {
    isLoopSelected.value = !isLoopSelected.value;
    isFloatSelected.value = !isFloatSelected.value;
  }

  onFloatPressed() {
    debugPrint("----->>>on Float Pressed<<<----");
    isLoopSelected.value = !isLoopSelected.value;
    isFloatSelected.value = !isFloatSelected.value;
  }

  Future<void> onSave() async {
    debugPrint("${freeModeRoute.runtimeType}");
    if (freeModeRoute.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String jsonString = jsonEncode(freeModeRoute);
      pref.setString(PrefString.loopRouteData, jsonString);
      String? savedLoopData = pref.getString(PrefString.loopRouteData);
      debugPrint('$savedLoopData');
    } else {
      debugPrint('Loop is empty!');
      return;
    }
  }

  onDragStart(DragStartDetails startDetails) {
    return freeModeRoute.clear();
  }

  Future<void> onDragEnd() async {
    debugPrint("-------::::::On Loop started:::::---------");

    while (isLoopSelected.value) {
      for (int i = 0; i < freeModeRoute.length; i++) {
        final byteData = Uint8List.fromList(freeModeRoute[i]);
        await _connectingDeviceController.sendData(byteData);
      }
    }
  }

  onDragUpdate(DragUpdateDetails updateDetails, double height) {
    left.value = max(0, left.value + updateDetails.delta.dx);
    top.value = max(0, top.value + updateDetails.delta.dy);

    if (top > 0) {
      int yAxisValue =
          (201 + (1 - top.value / height.customHeight) * 19).toInt();

      List<int> getPoints = [yAxisValue >> 8, yAxisValue & 0xff];

      final byteData = Uint8List.fromList(getPoints);
      _connectingDeviceController.sendData(byteData);

      // Adding data for loop mode
      freeModeRoute.add(getPoints);

      // generating route
      generatedRoute = generateList(freeModeRoute.length);
    }
  }

  List<List<int>> generateList(int numberOfLists) {
    List<List<int>> result = [];

    int previousValue = 0;

    for (int i = 0; i < numberOfLists; i++) {
      // int randomValue = (Random().nextInt(15) + 2).toInt();
      int firstValue = previousValue + 1;
      List<int> innerList = [firstValue];
      result.add(innerList);

      previousValue = firstValue;
    }

    return result;
  }
}
