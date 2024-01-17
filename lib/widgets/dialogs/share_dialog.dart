import 'package:flutter/material.dart';
import 'package:plaything/controller/connect_user_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/buttons/plaything_button.dart';

class ShareModalSheet extends StatelessWidget {
  ShareModalSheet({super.key});

  final ConnectUserController _connectUserController =
      Get.put(ConnectUserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.customWidth,
      height: 185.customHeight,
      padding: EdgeInsets.symmetric(
          vertical: 10.customHeight, horizontal: 15.customWidth),
      child: Obx(() {
        return Column(
          children: [
            Text(
              'Generate Code',
              style: theme.textTheme.headlineLarge,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.customHeight),
              child: Text(
                _connectUserController.code.value == 0
                    ? ''
                    : _connectUserController.code.value.toString(),
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: theme.textTheme.titleMedium!.fontWeight,
                    color: theme.textTheme.titleMedium!.color),
              ),
            ),
            Obx(() {
              return PlaythingButton(
                onPressed: () async {
                  await _connectUserController.saveUser();

                  _connectUserController.status.value == 'verified'
                      ? Get.toNamed(AppRoute.chatMode)
                      : null;
                },
                child: _connectUserController.creatingUser.isTrue
                    ? SizedBox(
                        height: 18.customHeight,
                        width: 18.customWidth,
                        child: CircularProgressIndicator(
                          color: appTheme.gray80001,
                          strokeWidth: 2.0,
                        ),
                      )
                    : Text(
                        'Generate Code',
                        style: TextStyle(
                          color: theme.textTheme.headlineLarge!.color,
                          fontWeight: theme.textTheme.titleMedium!.fontWeight,
                        ),
                      ),
              );
            }),
          ],
        );
      }),
    );
  }
}
