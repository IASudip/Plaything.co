import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/global.dart' as globals;

class ConnectingDeviceController extends GetxController {
  RxBool isScanningBLE = false.obs;

  final String _uuidService = "0000FFE5-0000-1000-8000-00805f9b34fb";
  final String _uuidRead = "0000FFE2-0000-1000-8000-00805f9b34fb";
  final String _uuidWrite = "0000FFE9-0000-1000-8000-00805f9b34fb";
  final String _uuidYaliBNotify = "0000FFE3-0000-1000-8000-00805f9b34fb";

  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> deviceList = <ScanResult>[].obs;
  BluetoothDevice? connectedDevice;
  RxInt batteryLevel = 0.obs;

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

    Map<Permission, PermissionStatus> fileManagerStatus =
        await [Permission.storage].request();
    debugPrint(
        "----->>>>>File Manager Permissions: $fileManagerStatus<<<<<-------");

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
    isScanningBLE.value = true;
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

      flutterBlue.scanResults.listen(
        (List<ScanResult> results) {
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
        },
      );
    }
  }

  Future<void> stopScanBluetooth() async {
    debugPrint("------>>Is Scanning: ${isScanningBLE.toString()}");
    if (isScanningBLE.isTrue) {
      flutterBlue.stopScan();
    }
    isScanningBLE.value = false;
    debugPrint("------->>>>Scanning has been Stopped<<<<<------");
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    if (isScanningBLE.isTrue) {
      flutterBlue.stopScan();
      isScanningBLE.value = false;
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
              globals.deviceState = "Connecting";
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
              globals.deviceState = "Connected";
              debugPrint("-------->>>>>>Device is ${state.name}<<<<----------");
              onDiscoveringServices(device);
              return;
            } else if (state == BluetoothDeviceState.disconnected) {
              globals.deviceState = "Disconnected";
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
          } else if (characteristic.uuid.toString() ==
              Guid(_uuidRead).toString()) {
            globals.readCharacteristic = characteristic;
            await globals.readCharacteristic!.read();

            globals.readCharacteristic!.value.listen(
              (List<int> resultList) {
                // debugPrint("----->>>Result List: $resultList<<<----");
                if (resultList[1] == 0x0 && resultList[2] == 0x0) {
                  batteryLevel.value = resultList[0] & 0xff;
                  // debugPrint("Your device battery Level is $batteryLevel");
                } else if ((resultList[2] & 0xff) == 0xff) {
                  int productMode = (resultList[3] & 0xff);
                  debugPrint("Your device battery Level is $productMode");
                } else {
                  debugPrint("----->>>No match Found <<<<------");
                }
              },
            );
            readBatteryMessage();
          } else if (characteristic.uuid.toString() ==
              Guid(_uuidYaliBNotify).toString()) {
            globals.yaliCharacteristic = characteristic;
          } else {
            debugPrint("---->>>No match found<<<----");
          }
        }
      }
    }
  }

  Future<void> readBatteryMessage() async {
    if (globals.writeCharacteristic != null) {
      String strVolt = "VOLT";
      List<int> bytes = utf8.encode(strVolt);
      if (globals.readCharacteristic!.properties.writeWithoutResponse) {
        globals.readCharacteristic!.write(bytes, withoutResponse: true);
      } else {
        globals.readCharacteristic!.write(bytes, withoutResponse: false);
      }
    }
  }

  Future<void> readProductMessage() async {
    if (globals.writeCharacteristic != null) {
      List<int> bytes = [
        'W'.codeUnitAt(0),
        'N'.codeUnitAt(0),
        'D'.codeUnitAt(0),
        'S'.codeUnitAt(0),
      ];
      Uint8List data = Uint8List.fromList(bytes);
      if (globals.readCharacteristic!.properties.writeWithoutResponse) {
        globals.readCharacteristic!.write(data);
      } else {
        globals.readCharacteristic!.write(data, withoutResponse: false);
      }
    }
  }

  Future<void> sendData(Uint8List bytes) async {
    try {
      debugPrint("---:::::Bytes: $bytes:::::-------");
      await globals.writeCharacteristic!.write(bytes, withoutResponse: true);
    } catch (e) {
      debugPrint(":::::::>>>>>>Error While Sending Data: $e<<<<<<::::::::");
    }
  }
}
