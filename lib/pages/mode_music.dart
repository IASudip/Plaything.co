import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/music_appbar.dart';

class MusicModePage extends StatefulWidget {
  const MusicModePage({super.key});

  @override
  State<MusicModePage> createState() => _MusicModePageState();
}

class _MusicModePageState extends State<MusicModePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const MusicModeAppBar(),
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
            ],
          ),
        ),
      ),
    );
  }
}
