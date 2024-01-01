import 'package:flutter/material.dart';
import 'package:plaything/controller/mode_music_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/pages/mode_music/mylibrary.dart';
import 'package:plaything/pages/mode_music/playlist.dart';
import 'package:plaything/widgets/appbar/music_appbar.dart';

class MusicModePage extends StatefulWidget {
  const MusicModePage({super.key});

  @override
  State<MusicModePage> createState() => _MusicModePageState();
}

class _MusicModePageState extends State<MusicModePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final MusicModeController _musicModeController =
      Get.put(MusicModeController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _musicModeController.getAudio();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MusicModeAppBar(
          controller: tabController,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: PlayThingFooter(
          color: appTheme.red30003,
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
              TabBarView(
                controller: tabController,
                children: const [
                  // Playlist TabView
                  MyLibraryTab(),

                  // Playlist TabView
                  PlaylistTab()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController!.dispose();
    _musicModeController.onDestroy();
    super.dispose();
  }
}
