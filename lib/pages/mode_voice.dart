import 'package:flutter/material.dart';
import 'package:plaything/controller/mode_voice_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';

class VoiceControlModePage extends StatefulWidget {
  const VoiceControlModePage({super.key});

  @override
  State<VoiceControlModePage> createState() => _VoiceControlModePageState();
}

class _VoiceControlModePageState extends State<VoiceControlModePage>
    with SingleTickerProviderStateMixin {
  final VoiceModeController voiceModeController =
      Get.put(VoiceModeController());

  late AnimationController _animationController;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    scale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const TitleAppBar(
        title: Text('Voice'),
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
              child: SvgPicture.asset(
                ImagePath.splashScreenLogo,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_animationController.isCompleted) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }

                if (voiceModeController.isRecording.value) {
                  voiceModeController.stop();
                } else {
                  voiceModeController.start();
                }
              },
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        -(width / 1.05) + (width / 1.05) * scale.value,
                        -(height / 2.0) + (height / 2.0) * scale.value,
                      ),
                      child: Transform.scale(
                        scale: scale.value,
                        child: CircleAvatar(
                          radius: _animationController.isAnimating ||
                                  _animationController.isCompleted
                              ? 83.5.customWidth + 150.customWidth * scale.value
                              : 83.5.customWidth,
                          backgroundColor: appTheme.gray800.withOpacity(0.1),
                          child: CircleAvatar(
                            radius: _animationController.isAnimating ||
                                    _animationController.isCompleted
                                ? 73.5.customWidth +
                                    85.customWidth * scale.value
                                : 73.5.customWidth,
                            backgroundColor: appTheme.gray800.withOpacity(0.2),
                            child: CircleAvatar(
                              radius: _animationController.isAnimating ||
                                      _animationController.isCompleted
                                  ? 61.3.customWidth +
                                      47.2.customWidth * scale.value
                                  : 61.3.customWidth,
                              backgroundColor:
                                  appTheme.gray800.withOpacity(0.4),
                              child: CircleAvatar(
                                radius: 48.5.customWidth,
                                backgroundColor: appTheme.gray800,
                                child: SvgPicture.asset(
                                  ImagePath.mic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    voiceModeController.stop();
    _animationController.dispose();
    super.dispose();
  }
}
