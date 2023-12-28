import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:plaything/core/app_export.dart';

import '../widgets/appbar/title_appbar.dart';

class TermsandConditionPage extends StatelessWidget {
  const TermsandConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: TitleAppBar(
        title: const Text('Terms & Condition'),
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
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 35.customWidth),
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
              Text(
                lorem(
                  paragraphs: 6,
                  words: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
