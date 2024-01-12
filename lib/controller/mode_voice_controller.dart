import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';

class VoiceModeController extends GetxController {
  final ConnectingDeviceController _connectingDeviceController =
      Get.put(ConnectingDeviceController());
  RxBool isRecording = false.obs;
  NoiseReading? latestReading;
  StreamSubscription<NoiseReading>? noiseSubscription;
  NoiseMeter? noiseMeter;

  double log10(num value) {
    return log(value) / ln10;
  }

  void onData(NoiseReading noiseReading) {
    latestReading = noiseReading;

    double meanDB = latestReading!.meanDecibel;
    double maxDB = latestReading!.maxDecibel;
    int minByte = 201;
    int maxByte = 219;

    if (meanDB <= 0 || maxDB <= 0) {
      debugPrint("Both meanDecibel and maxDecibel must be positive values.");
    }

    double decible = 20 * log10(maxDB / meanDB);

    decible =
        decible.clamp(latestReading!.meanDecibel, latestReading!.meanDecibel);

    int byteValue =
        (((decible - latestReading!.meanDecibel) / latestReading!.maxDecibel -
                        latestReading!.meanDecibel) *
                    (maxByte - minByte) +
                minByte)
            .toInt();
    debugPrint("---->>> total Decible $byteValue dB<<<----");

    Uint8List bytes = Uint8List.fromList([0x00, byteValue]);
    _connectingDeviceController.sendData(bytes);
  }

  void onError(Object error) {
    debugPrint(error.toString());
    stop();
  }

  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  Future<void> start() async {
    noiseMeter ??= NoiseMeter();

    if (!(await checkPermission())) await requestPermission();
    noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    isRecording.value = true;
  }

  void stop() {
    isRecording.value = false;
    Uint8List bytes = Uint8List.fromList([0x0, 255]);
    _connectingDeviceController.sendData(bytes);
    noiseSubscription?.cancel();
  }
}
