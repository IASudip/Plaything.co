import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:plaything/core/app_export.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
            height: 25.customHeight,
            width: 25.customWidth,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              ImagePath.backArrow,
              height: 19.customHeight,
              width: 11.customWidth,
            ),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 15.adaptSize,
              backgroundColor: appTheme.gray80001,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0.customWidth),
              child: const Text('User Name'),
            ),
          ],
        ),
        centerTitle: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                itemCount: 13,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.0.customWidth),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: width / 2,
                            margin: EdgeInsets.symmetric(
                              vertical: 13.0.customHeight,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.customWidth,
                              vertical: 5.0.customHeight,
                            ),
                            decoration: BoxDecoration(
                              color: appTheme.orange50,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                topRight: Radius.circular(5.0.adaptSize),
                                bottomLeft: Radius.circular(5.0.adaptSize),
                                bottomRight: Radius.circular(5.0.adaptSize),
                              ),
                            ),
                            child: Text(
                              lorem(words: 15, paragraphs: 1),
                              style: TextStyle(
                                fontFamily:
                                    theme.textTheme.labelMedium?.fontFamily,
                                color: theme.textTheme.labelMedium?.color,
                                fontSize: theme.textTheme.labelLarge?.fontSize,
                                fontWeight:
                                    theme.textTheme.displayMedium?.fontWeight,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: width / 2,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.customWidth,
                              vertical: 5.0.customHeight,
                            ),
                            decoration: BoxDecoration(
                              color: appTheme.deepOrange200,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                topRight: Radius.circular(5.0.adaptSize),
                                bottomLeft: Radius.circular(5.0.adaptSize),
                                bottomRight: Radius.circular(5.0.adaptSize),
                              ),
                            ),
                            child: Text(
                              lorem(words: 15, paragraphs: 1),
                              style: TextStyle(
                                fontFamily:
                                    theme.textTheme.labelMedium?.fontFamily,
                                color: theme.textTheme.labelMedium?.color,
                                fontSize: theme.textTheme.labelLarge?.fontSize,
                                fontWeight:
                                    theme.textTheme.displayMedium?.fontWeight,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
