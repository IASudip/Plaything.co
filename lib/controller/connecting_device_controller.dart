import 'dart:typed_data';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/global.dart' as globals;

class ConnectingDeviceController extends GetxController {
  bool isScanningBLE = false;

  final String _uuidService = "0000FFE5-0000-1000-8000-00805f9b34fb";
  final String _uuidRead = "0000FFE2-0000-1000-8000-00805f9b34fb";
  final String _uuidWrite = "0000FFE9-0000-1000-8000-00805f9b34fb";
  // final String _uuidYaliBNotify = "0000FFE3-0000-1000-8000-00805f9b34fb";

  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> deviceList = [];
  BluetoothDevice? connectedDevice;
  RxString bleState = "Loading...".obs;

  Future<bool> isBluetoothOn() async {
    bool isFbleOn = await Permission.bluetooth.serviceStatus.isEnabled;
    if (isFbleOn) {
      debugPrint("--------->>>>Bluetooh State: $isFbleOn<<<<----------");
      return true;
    } else {
      debugPrint("--------->>>>Bluetooh State: $isFbleOn<<<<----------");
      return false;
    }
  }

  Future<void> getPermission() async {
    bool bleScan = await Permission.bluetoothScan.isGranted;
    bool locStatus = await Permission.location.isGranted;

    bool isLocEnable = await isLocationEnable();
    bool isBleEnable = await isBluetoothOn();

    if (!locStatus || !bleScan) {
      isReqdPermissionGranted();
      return;
    } else if (!isBleEnable || !isLocEnable) {
      await showBluetoohDialog();
      await showGPSDialog();
    } else {
      startBleDeviceScan();
    }
  }

  Future<void> showBluetoohDialog() async {
    bool isFbleOn = await isBluetoothOn();
    if (!isFbleOn) {
      await BluetoothEnable.enableBluetooth;
      return;
    }
  }

  Future<void> showGPSDialog() async {
    bool isLocationOn = await isLocationEnable();
    if (!isLocationOn) {
      return Get.defaultDialog(
        title: 'Location',
        content: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                Get.back();
                await OpenSettings.openLocationSourceSetting();
                startBleDeviceScan();
              },
              child: const Text('Turn on'),
            )
          ],
        ),
      );
    }
  }

  Future<bool> isLocationEnable() async {
    bool gps = await Permission.location.serviceStatus.isEnabled;
    if (gps) {
      debugPrint("----->>>>Location Enable: $gps<<<<------");
      return true;
    } else {
      debugPrint("----->>>>Location Enable: $gps<<<<------");
      return false;
    }
  }

  Future<void> isReqdPermissionGranted() async {
    debugPrint("----->>>>>Initial Permissions Started<<<<<-------");

    bool locStatus = await Permission.location.request().isGranted;
    debugPrint("----->>>>>Location Scan Permissions: $locStatus<<<<<-------");

    bool blueScanStatus = await Permission.bluetoothScan.request().isGranted;
    debugPrint(
        "----->>>>Bluetooth Scan Permissions: $blueScanStatus<<<<<-----");

    bool blueAdvStatus =
        await Permission.bluetoothAdvertise.request().isGranted;
    debugPrint(
        "----->>>>>Bluetooth Advertise Permissions: $blueAdvStatus<<<<<-------");

    bool blueStatus = await Permission.bluetooth.request().isGranted;
    debugPrint("----->>>>>Bluetooth Permissions: $blueStatus<<<<<-------");

    bool blueConnectStatus =
        await Permission.bluetoothConnect.request().isGranted;
    debugPrint("----->>>>>Bluetooth Status: $blueConnectStatus<<<<<-------");

    await showBluetoohDialog();

    await showGPSDialog();
  }

  Future<void> startBleDeviceScan() async {
    isScanningBLE = true;
    deviceList.clear();

    if (await isBluetoothOn()) {
      debugPrint("------->>>>>Scanning Started<<<<<--------");
      await flutterBlue.startScan(
        allowDuplicates: false,
      );
    }
  }

  Future<void> getScannedDevice() async {
    bool btStatus = await Permission.bluetooth.isGranted;
    bool btStatusConnect = await Permission.bluetoothConnect.isGranted;
    bool btStatusScan = await Permission.bluetoothScan.isGranted;
    bool bleEnable = await Permission.bluetooth.serviceStatus.isEnabled;

    if (!btStatus && !btStatusConnect && !btStatusScan) {
      isReqdPermissionGranted();
      return;
    }

    if (btStatus && btStatusConnect && btStatusScan && bleEnable) {
      // flutterBlue.connectedDevices
      //     .asStream()
      //     .listen((List<BluetoothDevice> devices) {
      //   for (BluetoothDevice device in devices) {

      //   }
      // });

      flutterBlue.scanResults.listen((List<ScanResult> results) {
        for (ScanResult result in results) {
          int findIndex = deviceList.indexWhere(
            (element) => (element.device.id.id == result.device.id.id),
          );

          String bleName = result.device.name;
          if (findIndex == -1 && bleName.startsWith('Aogu')) {
            deviceList.add(result);
            debugPrint("------->>>>Device name: ${result.device}<<<<<------");
            stopScanBluetooth();
          }
        }
      });
    }
  }

  Future<void> stopScanBluetooth() async {
    debugPrint("------>>Is Scanning: ${isScanningBLE.toString()}");
    if (isScanningBLE) {
      flutterBlue.stopScan();
    }
    isScanningBLE = false;
    debugPrint("------->>>>Scanning has been Stopped<<<<<------");
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    if (isScanningBLE == true) {
      flutterBlue.stopScan();
      isScanningBLE = false;
    }
    List<BluetoothDevice> arrConnectedDevice =
        await FlutterBlue.instance.connectedDevices;
    List<BluetoothDevice> arrFilter = arrConnectedDevice.where((element) {
      return element.name.contains("Aogu");
    }).toList();

    if (arrFilter.isEmpty) {
      await device.connect();
      connectedDevice = device;
      debugPrint("----->>>Connected Device: $connectedDevice<<<------");

      if (connectedDevice != null) {
        device.state.listen(
          (BluetoothDeviceState state) {
            if (state == BluetoothDeviceState.connecting) {
              bleState.value = "Connecting";
              debugPrint("---->>>Device is ${state.name}<<<<----");
              Get.defaultDialog(
                content: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                ),
              );
              return;
            } else if (state == BluetoothDeviceState.connected) {
              debugPrint("-------->>>>>>Device is ${state.name}<<<<----------");
              onDiscoveringServices(device);
              return;
            } else if (state == BluetoothDeviceState.disconnected) {
              bleState.value = "Disconnected";
              debugPrint('--->>Device is ${state.name}<<---');
              Get.defaultDialog(
                backgroundColor: appTheme.gray80001,
                radius: 10.0.customWidth,
                barrierDismissible:
                    state == BluetoothDeviceState.disconnected ? false : true,
                title: 'Device State',
                titleStyle: theme.textTheme.labelLarge,
                content: Text(
                  '${device.name} is disconnected.\nPlease turn on your device.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodyMedium!.color,
                    fontFamily: theme.textTheme.titleMedium!.fontFamily,
                    fontWeight: theme.textTheme.titleMedium!.fontWeight,
                    fontSize: theme.textTheme.titleMedium!.fontSize,
                  ),
                ),
              );
              return;
            }
          },
        );
      }
    } else {
      connectedDevice = arrFilter.first;
    }
  }

  Future<void> onDiscoveringServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();

    for (BluetoothService service in services) {
      if (service.uuid.toString() == Guid(_uuidService).toString()) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic characteristic in characteristics) {
          if (characteristic.uuid.toString() == Guid(_uuidWrite).toString()) {
            globals.writeCharacteristic = characteristic;

            debugPrint(
                "---->>>Globals WriteCharacteristic: ${globals.writeCharacteristic!.uuid}<<<----");
            if (characteristic.properties.write) {
              Get.offAllNamed(AppRoute.mode);
            }
          }

          if (characteristic.uuid.toString() == _uuidRead.toString()) {
            List<String> splitUUID = characteristic.uuid.toString().split('-');
            String firstPart = splitUUID[0];
            String finalUUID = firstPart.replaceAll("0000", "");
            if (finalUUID == "FFE2") {
              globals.readCharacteristic = characteristic;
              return;
            }
            return;
          }

          /*else if (characteristic.uuid.toString() ==
              Guid(_uuidRead).toString()) {
            globals.readCharacteristic = characteristic;
            debugPrint(
                "---->>>Globals ReadCharacteristic: ${globals.readCharacteristic!.value.first}<<<----");

            globals.readCharacteristic!.value.listen((List<int> resultByte) {
              if (resultByte[1] == 0x0 && resultByte[2] == 0x00) {
                int batteryLevel = resultByte[0] & 0xff;
                debugPrint("Your device battery Level is $batteryLevel");
              } else if ((resultByte[2] & 0xff) == 0x40) {
                int productMode = (resultByte[3] & 0xff);
                debugPrint("Your device battery Level is $productMode");
              }
            });
          } else if (characteristic.uuid.toString() ==
              Guid(_uuidYaliBNotify).toString()) {
            globals.yaliCharacteristic = characteristic;
          } else {
            debugPrint("---->>>No match found<<<----");
          }*/
        }
      }
    }
  }

  Future<void> onCharacteristicRead(
      BluetoothCharacteristic characteristic) async {
    characteristic.value.listen((List<int> resultByte) {
      debugPrint("Battery: $resultByte");
    });
  }

  Future<void> sendData(BluetoothCharacteristic? c, Uint8List bytes) async {
    try {
      await c!.write(
        bytes,
      );
      debugPrint("---:::::Bytes: $bytes:::::-------");
    } catch (e) {
      debugPrint(":::::::>>>>>>Error While Sending Data: $e<<<<<<::::::::");
    }
  }
}
