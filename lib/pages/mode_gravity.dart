import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';

class GravityModePage extends StatefulWidget {
  const GravityModePage({super.key});

  @override
  State<GravityModePage> createState() => _GravityModePageState();
}

class _GravityModePageState extends State<GravityModePage>
    with TickerProviderStateMixin {
  List<double> circleRadius = [
    150.0,
    250.0,
    350.0,
  ];

  late AnimationController _gravityAnimationController;

  @override
  void initState() {
    super.initState();

    _gravityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
      lowerBound: 0.1,
      upperBound: 1.5,
    );
    _gravityAnimationController.addListener(() {
      setState(() {
        _gravityAnimationController.repeat(
          min: 1.0,
          max: 1.5,
        );
      });
    });
    _gravityAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: TitleAppBar(
        title: const Text('Gravity'),
        automaticallyImplyLeading: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const Text('Plaything.co'),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: appTheme.red20003,
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
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.05,
              child: SvgPicture.asset(
                ImagePath.splashScreenLogo,
              ),
            ),
            Container(
              height: 125.customHeight,
              width: 125.customHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appTheme.gray80001,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                height: 36.customHeight,
                width: 36.customWidth,
                child: SvgPicture.asset(
                  ImagePath.phoneVibration,
                ),
              ),
            ),
            Positioned(
              left: 77.customWidth,
              right: 128.customWidth,
              top: 311.customHeight,
              bottom: 348.customHeight,
              child: Opacity(
                opacity: 0.20,
                child: CircleAvatar(
                  radius: 185.customHeight,
                  backgroundColor: appTheme.gray80001,
                ),
              ),
            ),
            Positioned(
              right: 76.customWidth,
              left: 129.customWidth,
              top: 312.customHeight,
              bottom: 347.customHeight,
              child: Opacity(
                opacity: 0.20,
                child: CircleAvatar(
                  radius: 185.customHeight,
                  backgroundColor: appTheme.gray80001,
                ),
              ),
            ),
            Positioned(
              right: 100.customWidth,
              left: 105.customWidth,
              top: 348.customHeight,
              bottom: 311.customHeight,
              child: Opacity(
                opacity: 0.20,
                child: CircleAvatar(
                  radius: 185.customHeight,
                  backgroundColor: appTheme.gray80001,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _gravityAnimationController.stop();
    _gravityAnimationController.dispose();
    super.dispose();
  }
}
