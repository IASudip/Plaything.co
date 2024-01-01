import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/controldevice_appbar.dart';

class ConnectingDevicePage extends StatefulWidget {
  const ConnectingDevicePage({super.key});

  @override
  State<ConnectingDevicePage> createState() => _ConnectingDevicePageState();
}

class _ConnectingDevicePageState extends State<ConnectingDevicePage>
    with SingleTickerProviderStateMixin {
  double randmNo = Random().nextDouble();
  late AnimationController _animationController;

  final ConnectingDeviceController _controller = ConnectingDeviceController();

  List<double> circleRadius = [
    150.0,
    200.0,
    250.0,
    300.0,
    350.0,
  ];

  @override
  void initState() {
    super.initState();

    _controller.getScannedDevice();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
      lowerBound: 0.1,
      upperBound: 1.5,
    );
    _animationController.addListener(() {
      setState(() {
        _animationController.repeat(
          min: 1.0,
          max: 1.5,
        );
      });
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const ConnectDeviceAppBar(
        title: Text(
          'Connecting Device',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  ImagePath.splashScreenLogo,
                ),
              ),
              RippleContainer(
                radius: circleRadius[0],
                animationValue: _animationController.value,
              ),
              RippleContainer(
                radius: circleRadius[1],
                animationValue: _animationController.value,
              ),
              RippleContainer(
                radius: circleRadius[2],
                animationValue: _animationController.value,
              ),
              RippleContainer(
                radius: circleRadius[3],
                animationValue: _animationController.value,
              ),
              SvgPicture.asset(
                ImagePath.bluetooth,
              ),
              Positioned(
                left: 2.customWidth,
                right: 160.customWidth,
                child: Visibility(
                  visible: _controller.deviceList.isEmpty ? false : true,
                  child: GestureDetector(
                    onTap: () async {
                      if (_controller.deviceList.isNotEmpty &&
                          _controller.deviceList.first.device.name
                              .startsWith('Aogu')) {
                        _controller
                            .connectDevice(_controller.deviceList.first.device);
                      } else {
                        debugPrint('No device found');
                        return;
                      }
                    },
                    child: Image.asset(
                      ImagePath.femaleToy,
                      height: 112.customHeight,
                      width: 43.customWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }
}
