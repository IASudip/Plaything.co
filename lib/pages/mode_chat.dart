import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/controldevice_appbar.dart';

class ChatModePage extends StatelessWidget {
  const ChatModePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      // To-do Change AppBar
      // appBar: const TitleAppBar(
      //   title: Text('Chat'),
      //   automaticallyImplyLeading: true,
      // ),
      appBar: const ConnectDeviceAppBar(title: Text('Chats')),
      bottomNavigationBar: PlayThingFooter(
        color: appTheme.red30003,
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
            SizedBox(
              width: width,
              height: height,
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.0.customWidth),
                    child: ListTile(
                      onTap: () => Get.toNamed(AppRoute.chatRoom),
                      leading: CircleAvatar(
                        backgroundColor: appTheme.gray80001,
                      ),
                      title: const Text('User Name'),
                      titleTextStyle: theme.textTheme.bodyMedium,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
