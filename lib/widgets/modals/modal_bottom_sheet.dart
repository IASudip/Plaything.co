import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:plaything/controller/connect_user_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/buttons/plaything_button.dart';

class ConnectModalSheet extends StatefulWidget {
  const ConnectModalSheet({super.key});

  @override
  State<ConnectModalSheet> createState() => _ConnectModalSheetState();
}

class _ConnectModalSheetState extends State<ConnectModalSheet> {
  final ConnectUserController _connectUserController =
      Get.find<ConnectUserController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Container(
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
                color: theme.textTheme.titleSmall!.color,
                fontSize: theme.textTheme.titleMedium!.fontSize,
                fontWeight: theme.textTheme.titleMedium!.fontWeight,
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
            autoDisposeControllers: false,
            controller: _connectUserController.codeController,
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
          Obx(() {
            return PlaythingButton(
              onPressed: () => _connectUserController.sendAccessRequest(),
              child: _connectUserController.authSharedCode.isTrue
                  ? SizedBox(
                      height: 18.customHeight,
                      width: 18.customWidth,
                      child: CircularProgressIndicator(
                        color: appTheme.gray80001,
                        strokeWidth: 2.0,
                      ),
                    )
                  : Text(
                      'Request Access',
                      style: TextStyle(
                        color: theme.textTheme.headlineLarge!.color,
                        fontWeight: theme.textTheme.titleMedium!.fontWeight,
                      ),
                    ),
            );
          })
        ],
      ),
    );
  }
}
