import 'package:flutter/material.dart';
import 'package:plaything/controller/connect_user_controller.dart';
import 'package:plaything/controller/connecting_device_controller.dart';
import 'package:plaything/core/app_export.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final ConnectingDeviceController _controller =
      Get.put(ConnectingDeviceController());
  final ConnectUserController _connectUserController =
      Get.put(ConnectUserController());

  @override
  void initState() {
    _controller.getPermission();

    // Future.delayed(const Duration(seconds: 3), () async {
    //   SharedPreferences pref = await SharedPreferences.getInstance();
    //   String? check = pref.getString(PrefString.privacyPolicyRead);
    //   debugPrint("---->>>Is aggred: $check<<<---");
    //   if (check == "true") {
    //     Get.offAllNamed(AppRoute.connectDevice);
    //     return;
    //   } else {
    //     Get.offAllNamed(AppRoute.privacyPolicyInitial);
    //     return;
    //   }
    // });

    Future.delayed(const Duration(seconds: 3), () {});
    _connectUserController.checkRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 25.customWidth),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appTheme.red20003,
          gradient: LinearGradient(
            begin: const Alignment(0.5, 0),
            end: const Alignment(0.5, 1),
            colors: [
              appTheme.gray400,
              appTheme.red30003,
            ],
          ),
        ),
        child: SvgPicture.asset(ImagePath.splashScreenLogo),
      ),
    );
  }
}
