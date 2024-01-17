import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/utlis/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModePageController extends GetxController {
  final List<ModeType> modes = [
    ModeType(
      mode: 'Pattern',
      icon: ImagePath.patternMode,
      onTap: () => Get.toNamed(AppRoute.patternMode),
    ),
    ModeType(
      mode: 'Music',
      icon: ImagePath.musicMode,
      onTap: () => Get.toNamed(AppRoute.musicMode),
    ),
    ModeType(
      mode: 'Free Mode',
      icon: ImagePath.freeMode,
      onTap: () => Get.toNamed(AppRoute.freeMode),
    ),
    ModeType(
      mode: 'Gravity',
      icon: ImagePath.gravityMode,
      onTap: () => Get.toNamed(AppRoute.gravityMode),
    ),
    ModeType(
      mode: 'Long Distance',
      icon: ImagePath.gravityMode,
      onTap: () => Get.toNamed(AppRoute.access),
    ),
    ModeType(
      mode: 'Voice Control',
      icon: ImagePath.gravityMode,
      onTap: () => Get.toNamed(AppRoute.voiceControlMode),
    ),
    ModeType(
      mode: 'Chat',
      icon: ImagePath.chatMode,
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? prefUserID = preferences.getString(PrefString.docID);
        if (prefUserID == null) {
          Get.toNamed(AppRoute.access);
        } else {
          Get.toNamed(AppRoute.chatMode);
        }
      },
    ),
  ];
}

class ModeType {
  final String mode;
  final String icon;
  final VoidCallback? onTap;
  ModeType({
    required this.mode,
    required this.icon,
    required this.onTap,
  });
}
