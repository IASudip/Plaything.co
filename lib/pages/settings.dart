import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';
import 'package:plaything/widgets/settings_option.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool enableNotify = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: TitleAppBar(
        title: const Text('Setting'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const Text('Plaything.co'),
      body: Container(
        width: width,
        height: height,
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
        child: Stack(
          children: [
            Center(
              child: Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  ImagePath.splashScreenLogo,
                ),
              ),
            ),
            Container(
                height: double.maxFinite,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 25.customWidth),
                child: Column(
                  children: [
                    SettingsOption(
                      onTap: () {
                        setState(() {
                          if (!enableNotify) {
                            enableNotify = true;
                          } else {
                            enableNotify = false;
                          }
                        });
                      },
                      title: 'Notifications',
                      trailing: SizedBox(
                        width: 38.0.fSize,
                        height: 17.0.fSize,
                        child: FlutterSwitch(
                            toggleSize: 13.0.fSize,
                            padding: 2.0.fSize,
                            activeColor: appTheme.gray80001,
                            inactiveColor: appTheme.orange50,
                            inactiveToggleColor: appTheme.deepOrange20001,
                            activeToggleColor: appTheme.deepOrange20001,
                            value: enableNotify,
                            onToggle: (v) {
                              setState(() {
                                enableNotify = v;
                              });
                            }),
                      ),
                    ),
                    SettingsOption(
                      onTap: () => Get.toNamed(AppRoute.privacyPolicy),
                      title: 'Privacy Policy',
                    ),
                    SettingsOption(
                      onTap: () => Get.toNamed(AppRoute.termsCondition),
                      title: 'Terms & Conditions',
                    ),
                    SettingsOption(
                      onTap: () => Get.toNamed(AppRoute.licenseAgreement),
                      title: 'License Agreement',
                    ),
                    SettingsOption(
                      onTap: () {},
                      title: 'Check for update',
                      divider: false,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
