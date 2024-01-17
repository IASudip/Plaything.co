import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/controller/mode_free_controller.dart';
import 'package:plaything/controller/mode_music_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/pages/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));

  Get.lazyPut(() => ConnectingDeviceController());
  Get.lazyPut(() => MusicModeController());
  Get.lazyPut(() => FreeModeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        fallbackLocale: const Locale('en', 'US'),
        getPages: AppRoute.pages,
        home: const SplashPage(),
      ),
    );
  }
}
