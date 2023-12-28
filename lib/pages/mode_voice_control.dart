import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';

class VoiceControlPage extends StatefulWidget {
  const VoiceControlPage({super.key});

  @override
  State<VoiceControlPage> createState() => _VoiceControlPageState();
}

class _VoiceControlPageState extends State<VoiceControlPage>
    with TickerProviderStateMixin {
  List<double> circleRadius = [
    150.0,
    200.0,
    250.0,
    300.0,
    350.0,
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

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
      appBar: TitleAppBar(
        title: const Text('Voice'),
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
        child: Center(
          child: Stack(alignment: Alignment.center, children: [
            Opacity(
              opacity: 0.05,
              child: SvgPicture.asset(ImagePath.splashScreenLogo),
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
              ImagePath.mic,
            ),
          ]),
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
