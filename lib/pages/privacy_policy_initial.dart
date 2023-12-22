import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/core/utlis/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicyInitialPage extends StatefulWidget {
  const PrivacyPolicyInitialPage({super.key});

  @override
  State<PrivacyPolicyInitialPage> createState() =>
      _PrivacyPolicyInitialPageState();
}

class _PrivacyPolicyInitialPageState extends State<PrivacyPolicyInitialPage> {
  bool _agreed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
            color: appTheme.gray400,
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
              SvgPicture.asset(
                ImagePath.privacyPolicyWallpaper,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 142.0.customHeight,
                bottom: 185.customHeight,
                left: 71.customWidth,
                right: 29.0.customWidth,
                child: SizedBox(
                  width: 290.customWidth,
                  height: 447.customHeight,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 27.0.customHeight,
                        ),
                        child: Text(
                          'Privacy Policy',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        lorem(
                          paragraphs: 4,
                          words: 220,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 22,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox.adaptive(
                            activeColor: appTheme.orange50,
                            checkColor: appTheme.gray80001,
                            value: _agreed,
                            onChanged: (v) {
                              setState(() {
                                _agreed = v!;
                              });
                            },
                          ),
                          Text(
                            'I agreed to all Privacy Policy',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 721.0.customHeight,
                left: 88.customWidth,
                right: 162.0.customWidth,
                bottom: 99.0.customHeight,
                child: InkWell(
                  onTap: () async {
                    if (_agreed) {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                        PrefString.privacyPolicyRead,
                        _agreed.toString(),
                      );

                      Get.toNamed(AppRoute.connectDevice);
                      return;
                    } else {
                      Get.snackbar(
                        'Privacy Policy',
                        'Please agree to privacy policy to proceed forward.',
                      );
                      return;
                    }
                  },
                  child: SizedBox(
                    height: 30.customHeight,
                    width: 60.customWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            'Get Started',
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        SvgPicture.asset(ImagePath.getStartedArrow),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
