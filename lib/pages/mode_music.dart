import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/music_appbar.dart';

class MusicModePage extends StatefulWidget {
  const MusicModePage({super.key});

  @override
  State<MusicModePage> createState() => _MusicModePageState();
}

class _MusicModePageState extends State<MusicModePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  // final OnAudioQuery _audioQuery = OnAudioQuery();
  // bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    // LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    // _audioQuery.setLogConfig(logConfig);
    // checkAndRequestPermissions();
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
                children: [
                  // Playlist TabView
                  SizedBox(
                    height: height,
                    width: width,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20.customWidth,
                            backgroundColor: appTheme.gray80001,
                            child: SvgPicture.asset(
                                height: 16.customHeight,
                                width: 16.customWidth,
                                ImagePath.playIcon),
                          ),
                          title: Text(
                            lorem(words: 4, paragraphs: 1),
                          ),
                        );
                      },
                    ),
                  ),

                  // Playlist TabView
                  SizedBox(
                    height: height,
                    width: width,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: appTheme.gray80001,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: SvgPicture.asset(
                              height: 18.customHeight,
                              width: 18.customWidth,
                              ImagePath.heartIcon,
                            ),
                          ),
                          title: Text(
                            lorem(words: 2, paragraphs: 1),
                          ),
                          subtitle: Text('$index songs'),
                        );
                      },
                    ),
                  ),
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
    super.dispose();
  }

  // checkAndRequestPermissions({bool retry = false}) async {
  //   _hasPermission = await _audioQuery.checkAndRequest(
  //     retryRequest: retry,
  //   );

  //   _hasPermission ? setState(() {}) : null;
  // }
}
