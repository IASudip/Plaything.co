import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:plaything/core/app_export.dart';

class MusicModeController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  final OnAudioQuery audioQuery = OnAudioQuery();

  RxList<SongModel> musicList = <SongModel>[].obs;
  RxList<AlbumModel> albumList = <AlbumModel>[].obs;

  RxList<SongModel> get musicFile => musicList;
  RxList<AlbumModel> get albumFile => albumList;

  bool isPlaying = false;

  Future<void> getAudio() async {
    musicList.value = await audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<void> getAlbum() async {
    albumList.value = await audioQuery.queryAlbums(
      sortType: AlbumSortType.ALBUM,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<void> playAudio(SongModel audioFile) async {
    if (player.state == PlayerState.playing) {
      await player.pause();
      isPlaying = false;
      return;
    } else {
      isPlaying = true;
      try {
        await player.stop();
        await player.play(
          DeviceFileSource(audioFile.data),
        );
      } catch (e) {
        debugPrint('Error Message while palying music: $e');
      }
      return;
    }
  }

  double getGain(int i, int numFrames, List<int> frameGains) {
    int x = i.clamp(0, numFrames - 1);
    if (numFrames < 2) {
      return frameGains[x].toDouble();
    } else {
      if (x == 0) {
        return (frameGains[0] / 2.0) + (frameGains[1] / 2.0);
      } else if (x == numFrames - 1) {
        return (frameGains[numFrames - 2] / 2.0) +
            (frameGains[numFrames - 1] / 2.0);
      } else {
        return frameGains[x - 1] / 3.0 +
            frameGains[x] / 3.0 +
            frameGains[x + 1] / 3.0;
      }
    }
  }

  Future<void> createMusicByte() async {
    if (isPlaying) {
      // int position = (await player.getCurrentPosition())!.inMilliseconds;
      // int total = (await player.getDuration())!.inMilliseconds;

      // double value =
      //     getGain((position ~/ (total * 1.0)).toInt(), 10, [10, 20, 20]);
    }
  }
}
