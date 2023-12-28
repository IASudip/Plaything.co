import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:plaything/core/app_export.dart';

import '../../controller/mode_music_controller.dart';

class PlaylistTab extends StatelessWidget {
  const PlaylistTab({super.key});

  @override
  Widget build(BuildContext context) {
    final MusicModeController musicModeController =
        Get.find<MusicModeController>();

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Obx(() {
      return SizedBox(
        height: height,
        width: width,
        child: musicModeController.albumFile.isEmpty
            ? const Center(
                child: Text(
                  'No album found',
                ),
              )
            : ListView.builder(
                itemCount: musicModeController.albumFile.length,
                itemBuilder: (context, index) {
                  AlbumModel albumData = musicModeController.albumFile[index];
                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appTheme.gray80001,
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                      child: SvgPicture.asset(
                        height: 18.customHeight,
                        width: 18.customWidth,
                        ImagePath.heartIcon,
                      ),
                    ),
                    title: Text(
                      albumData.album,
                    ),
                    subtitle: Text(
                      '${albumData.numOfSongs}',
                    ),
                  );
                },
              ),
      );
    });
  }
}
