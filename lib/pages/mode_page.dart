import 'package:flutter/material.dart';
import 'package:plaything/controller/mode_page_controller.dart';
import 'package:plaything/core/app_export.dart';
import 'package:plaything/widgets/appbar/mode_appbar.dart';
import 'package:plaything/widgets/neumorph_button.dart';

class ModePage extends StatefulWidget {
  const ModePage({super.key});

  @override
  State<ModePage> createState() => _ModePageState();
}

class _ModePageState extends State<ModePage>
    with SingleTickerProviderStateMixin {
  final ModePageController _modePageController = Get.put(ModePageController());
  late AnimationController _animController;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    scale = Tween<double>(
      begin: 0.0,
      end: 0.8,
    ).animate(_animController);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const ModeAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const PlayThingFooter(
        color: Colors.transparent,
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
              alignment: Alignment(0, -1.0.customHeight),
              child: Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  ImagePath.splashScreenLogo,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _animController,
                      builder: (context, child) {
                        return Builder(builder: (context) {
                          return Transform.translate(
                            offset: const Offset(0, 0),
                            child: Transform.scale(
                              scale: 0.75,
                              child: Image.asset(
                                ImagePath.femaleToy,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Wrap(
                    runSpacing: 5.0.customWidth,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      _modePageController.modes.length,
                      (index) => InkWell(
                        onTap: _modePageController.modes[index].onTap,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.customHeight,
                            horizontal: 10.0.customWidth,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 15.0.customHeight,
                                ),
                                child: Text(
                                  _modePageController.modes[index].mode,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              NeumorphismButton(
                                onTap: _modePageController.modes[index].onTap,
                                height: 65.customHeight,
                                width: 65.customWidth,
                                child: SvgPicture.asset(
                                  _modePageController.modes[index].icon,
                                  height: 25.customHeight,
                                  width: 25.customWidth,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}
