import 'package:flutter/material.dart';
import 'package:plaything/controller/connect_user_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/controldevice_appbar.dart';

class AccessPage extends StatelessWidget {
  AccessPage({super.key});

  final ConnectUserController _connectUserController =
      Get.put(ConnectUserController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      // appBar: const TitleAppBar(
      //   title: Text('Access'),
      // ),
      appBar: const ConnectDeviceAppBar(title: Text('Remote')),
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
                      onTap: () => _connectUserController.showShareSheet(),
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
                      onTap: () => _connectUserController.showConnetSheet(),
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
