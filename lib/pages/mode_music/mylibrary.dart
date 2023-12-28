import 'package:flutter/material.dart';
import 'package:plaything/controller/mode_music_controller.dart';
import 'package:plaything/core/app_export.dart';

class MyLibraryTab extends StatelessWidget {
  const MyLibraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final MusicModeController musicModeController =
        Get.put(MusicModeController());

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Obx(() {
      return SizedBox(
        height: height,
        width: width,
        child: musicModeController.musicFile.isEmpty
            ? const Center(
                child: Text(
                  'No music found',
                ),
              )
            : ListView.builder(
                itemCount: musicModeController.musicFile.length,
                itemBuilder: (context, index) {
                  final listAudio = musicModeController.musicFile[index];

                  return ListTile(
                    leading: InkWell(
                      onTap: () {
                        musicModeController.playAudio(listAudio);
                      },
                      child: CircleAvatar(
                        radius: 20.customWidth,
                        backgroundColor: appTheme.gray80001,
                        child: SvgPicture.asset(
                          height: 16.customHeight,
                          width: 16.customWidth,
                          ImagePath.playIcon,
                        ),
                      ),
                    ),
                    title: Text(
                      listAudio.title,
                    ),
                  );
                },
              ),
      );
    });
  }
}
