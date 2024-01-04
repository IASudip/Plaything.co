import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';

class MusicModeController extends GetxController {
  final ConnectingDeviceController _connectingDeviceController =
      Get.put(ConnectingDeviceController());

  final OnAudioQuery audioQuery = OnAudioQuery();
  final PlayerController playerController = PlayerController();

  RxList<SongModel> musicList = <SongModel>[].obs;
  RxList<AlbumModel> albumList = <AlbumModel>[].obs;

  RxList<SongModel> get musicFile => musicList;
  RxList<AlbumModel> get albumFile => albumList;
  int playId = 0;
  int numFrames = 0;
  List<double> audioFrames = [];
  List<int> frameGains = [];
  double scaleFactor = 0.0;
  double minGain = 0.0;
  double range = 0.0;

  Future<void> getAudio() async {
    bool checkWritePermission = await audioQuery.checkAndRequest();
    debugPrint("---->>>Check Write Permission: $checkWritePermission<<<-----");
    if (checkWritePermission) {
      musicList.clear();
      musicList.value = await audioQuery.querySongs(
        sortType: SongSortType.TITLE,
        uriType: UriType.EXTERNAL,
      );
    } else {
      await [Permission.storage].request();
      return;
    }
  }

  Future<void> getAlbum() async {
    bool checkWritePermission = await audioQuery.checkAndRequest();
    debugPrint("---->>>Check Write Permission: $checkWritePermission<<<-----");
    if (checkWritePermission == true) {
      albumList.value = await audioQuery.queryAlbums(
        sortType: AlbumSortType.ALBUM,
        uriType: UriType.EXTERNAL,
      );
      return;
    } else {
      await [Permission.storage].request();
      return;
    }
  }

  List<int> getFrameGain(List<double> audioFrames) {
    List<int> frameGains = [];
    for (double amplitude in audioFrames) {
      double frameGain = amplitude / 32767.0;
      frameGains.add(frameGain.toInt());
    }

    return frameGains;
  }

  double getGain(int i, int numFrames, List<int> frameGains) {
    int x = i.clamp(i, numFrames - 1);
    if (numFrames < 2) {
      return frameGains[x].toDouble();
    } else {
      if (x == 0) {
        return (frameGains[0] / 2.0) + (frameGains[1] / 2.0);
      } else if (x == (numFrames - 1)) {
        return (frameGains[numFrames - 2] / 2.0) +
            (frameGains[numFrames - 1] / 2.0);
      } else {
        return (frameGains[x - 1] / 3.0) +
            (frameGains[x] / 3.0) +
            (frameGains[x + 1] / 3.0);
      }
    }
  }

  Future<void> sendMessage() async {
    debugPrint("----->>>PlayerState: ${playerController.playerState}<<<-----");
    if (playerController.playerState.isInitialised) {
      int position = 0;

      playerController.onCurrentDurationChanged.listen((event) {
        position = event;
      });

      int total = await playerController.getDuration(DurationType.max);
      double value = getGain(
        (position ~/ (total * 1.0) * audioFrames.length),
        audioFrames.length,
        getFrameGain(audioFrames),
      ).toDouble();

      int sendData = 400 + ((value - minGain) ~/ (range * 300));
      Uint8List bytes = Uint8List.fromList([sendData >> 8, sendData & 0xFF]);

      while (playerController.playerState.isPlaying) {
        debugPrint(
            "----->>>Player State: ${playerController.playerState}<<<------");
        await _connectingDeviceController.sendData(bytes);
      }
    }
  }

  Future<void> playMusic(SongModel audioFile) async {
    if (playerController.playerState.isPlaying) {
      await playerController.stopPlayer();
    } else {
      playerController.stopAllPlayers();
      await playerController.preparePlayer(path: audioFile.data);
      audioFrames = await playerController
          .extractWaveformData(path: audioFile.data)
          .whenComplete(
        () {
          debugPrint("Extraction has been completed.");
          playerController.startPlayer();
          sendMessage();
        },
      );
    }

    try {
      int numFrames = audioFrames.length;
      double maxGain = 1.0;
      frameGains = getFrameGain(audioFrames);
      for (var i = 0; i < numFrames; i++) {
        double gain = getGain(i, numFrames, frameGains);
        if (gain > maxGain) {
          maxGain = gain;
        }
        scaleFactor = 1.0;
        if (maxGain > 255.0) {
          scaleFactor = 255 / maxGain;
        }
        maxGain = 0;
        List<int> gainHist = [256];
        for (var i = 0; i < numFrames; i++) {
          int smoothedGain =
              (getGain(i, numFrames, frameGains) * scaleFactor).toInt();
          if (smoothedGain < 0) {
            smoothedGain = 0;
          }
          if (smoothedGain > 255) {
            smoothedGain = 255;
          }
          if (smoothedGain > maxGain) {
            maxGain = smoothedGain.toDouble();
          }
          gainHist[smoothedGain];
        }
        minGain = 0;
        int sum = 0;
        while (minGain < 255 && sum < numFrames / 20) {
          sum += gainHist[minGain.toInt()];
          minGain++;
        }

        sum = 0;
        while (maxGain > 2 && sum < numFrames / 100) {
          sum += gainHist[maxGain.toInt()];
          maxGain--;
        }
        range = maxGain - minGain;
      }
    } catch (e) {
      e.printError();
    }
  }

  void onDestroy() async {
    Uint8List bytes = Uint8List.fromList([0x0, 255]);
    await _connectingDeviceController.sendData(bytes);
    playerController.stopAllPlayers();
    playerController.dispose();
  }
}
