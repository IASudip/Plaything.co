import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/theme/theme_helper.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';
import 'package:plaything/widgets/buttons/plaything_button.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  int? generatedCode;
  @override
  void initState() {
    super.initState();
    generateCode();
  }

  int? generateCode() {
    var random = Random();
    generatedCode = random.nextInt(999999) + 100000;
    debugPrint("--->>>Gen Code: $generatedCode<<<---");
    return generatedCode;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const TitleAppBar(
        title: Text('Access'),
      ),
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
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  ImagePath.splashScreenLogo,
                ),
              ),
            ),
            Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        int generatedCode = 0;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: appTheme.gray400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                  width: 350.customWidth,
                                  height: 215.customHeight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.customHeight,
                                      horizontal: 15.customWidth),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Generate Code',
                                        style: theme.textTheme.headlineLarge,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.customHeight),
                                        child: Text(
                                          generatedCode.toString(),
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: theme.textTheme
                                                  .titleMedium!.fontWeight,
                                              color: theme.textTheme
                                                  .titleMedium!.color),
                                        ),
                                      ),
                                      PlaythingButton(
                                        onPressed: () {},
                                        label: 'Generate Code',
                                      ),
                                      TextButton.icon(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.refresh_rounded,
                                          color: appTheme.gray800,
                                          size: 16,
                                        ),
                                        label: Text(
                                          'Re-generate Code',
                                          style: theme.textTheme.titleSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: CircleAvatar(
                        radius: 55.customWidth,
                        backgroundColor: appTheme.gray80001,
                        child: Icon(
                          Icons.upload,
                          size: 28.customWidth,
                          color: appTheme.deepOrange200,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Share'),
                    )
                  ],
                ),
                SizedBox(
                  width: 25.customWidth,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: appTheme.gray400,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                height: 225.customHeight,
                                width: width.customWidth,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.customWidth,
                                  vertical: 25.customHeight,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Shared Code',
                                        style: TextStyle(
                                          color:
                                              theme.textTheme.titleSmall!.color,
                                          fontSize: theme
                                              .textTheme.titleMedium!.fontSize,
                                          fontWeight: theme.textTheme
                                              .titleMedium!.fontWeight,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Enter the unique code shared by your partner to grant access.',
                                        style: theme.textTheme.labelMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.customHeight,
                                    ),
                                    PinCodeTextField(
                                      appContext: context,
                                      length: 6,
                                      keyboardType: TextInputType.number,
                                      pinTheme: PinTheme(
                                        selectedColor: appTheme.gray80001,
                                        activeColor: appTheme.gray80001,
                                        inactiveColor: appTheme.gray80001,
                                        inactiveFillColor: appTheme.gray80001,
                                      ),
                                    ),
                                    PlaythingButton(
                                      onPressed: () {},
                                      label: 'Request Access',
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 55.customWidth,
                        backgroundColor: appTheme.gray80001,
                        child: Icon(
                          Icons.download,
                          size: 28.customWidth,
                          color: appTheme.deepOrange200,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Connect'),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
