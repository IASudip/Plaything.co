import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/title_appbar.dart';

class LicenseAgreementPage extends StatelessWidget {
  const LicenseAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const TitleAppBar(
        title: Text('License Agreement'),
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
              padding: EdgeInsets.symmetric(horizontal: 35.customWidth),
              child: Text(
                lorem(
                  paragraphs: 4,
                  words: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
