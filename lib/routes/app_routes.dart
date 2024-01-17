import 'package:plaything/core/app_export.dart';
import 'package:plaything/pages/access_page.dart';
import 'package:plaything/pages/chat_room_page.dart';
import 'package:plaything/pages/connecting_device.dart';
import 'package:plaything/pages/license_agreement.dart';
import 'package:plaything/pages/mode_chat.dart';
import 'package:plaything/pages/mode_free.dart';
import 'package:plaything/pages/mode_gravity.dart';
import 'package:plaything/pages/mode_longdistance.dart';
import 'package:plaything/pages/mode_music/mode_music_page.dart';
import 'package:plaything/pages/mode_page.dart';
import 'package:plaything/pages/mode_pattern.dart';
import 'package:plaything/pages/mode_voice.dart';
import 'package:plaything/pages/privacy_policy.dart';
import 'package:plaything/pages/privacy_policy_initial.dart';
import 'package:plaything/pages/settings.dart';
import 'package:plaything/pages/splashscreen.dart';
import 'package:plaything/pages/terms_conditions.dart';

class AppRoute {
  static const String spalshPage = '/splash_page';
  static const String privacyPolicyInitial = '/privacy_policy_initial';
  static const String connectDevice = '/connect_device';

  static const String mode = '/mode';
  static const String patternMode = '/pattern_mode';
  static const String musicMode = '/music_mode';
  static const String freeMode = '/free_mode';
  static const String gravityMode = '/gravity_mode';
  static const String longDistanceMode = '/longDistance_mode';
  static const String voiceControlMode = '/voiceControl_mode';
  static const String chatMode = '/chat_mode';
  static const String chatRoom = '/chat_room';

  static const String access = '/access';

  static const String setting = '/setting';
  static const String privacyPolicy = '/privacy_policy';
  static const String termsCondition = '/terms_condition';
  static const String licenseAgreement = '/licenseAgreement_page';

  static List<GetPage> pages = [
    GetPage(
      name: spalshPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: privacyPolicyInitial,
      page: () => const PrivacyPolicyInitialPage(),
    ),
    GetPage(
      name: connectDevice,
      page: () => const ConnectingDevicePage(),
    ),
    GetPage(
      name: mode,
      page: () => const ModePage(),
    ),
    GetPage(
      name: patternMode,
      page: () => const PatternModePage(),
    ),
    GetPage(
      name: musicMode,
      page: () => const MusicModePage(),
    ),
    GetPage(
      name: freeMode,
      page: () => FreeModePage(),
    ),
    GetPage(
      name: gravityMode,
      page: () => const GravityModePage(),
    ),
    GetPage(
      name: longDistanceMode,
      page: () => const LongDistanceModePage(),
    ),
    GetPage(
      name: voiceControlMode,
      page: () => const VoiceControlModePage(),
    ),
    GetPage(
      name: chatMode,
      page: () => const ChatModePage(),
    ),
    GetPage(
      name: chatRoom,
      page: () => const ChatRoomPage(),
    ),
    GetPage(
      name: access,
      page: () => AccessPage(),
    ),
    GetPage(
      name: setting,
      page: () => const SettingPage(),
    ),
    GetPage(
      name: termsCondition,
      page: () => const TermsandConditionPage(),
    ),
    GetPage(
      name: privacyPolicy,
      page: () => const PrivacyPolicyPage(),
    ),
    GetPage(
      name: licenseAgreement,
      page: () => const LicenseAgreementPage(),
    ),
  ];
}
