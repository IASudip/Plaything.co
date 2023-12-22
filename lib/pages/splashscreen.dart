import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/utlis/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? check = pref.getString(PrefString.privacyPolicyRead);
      if (check == "true") {
        Get.offAllNamed(AppRoute.connectDevice);
        return;
      } else {
        Get.offAllNamed(AppRoute.privacyPolicyInitial);
        return;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
        child: SvgPicture.asset(
          ImagePath.splashScreenLogo,
        ),
      ),
    );
  }
}
