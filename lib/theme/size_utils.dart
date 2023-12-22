import 'package:flutter/material.dart';

// This functions are responsible to make UI responsive across all the mobile devices.

MediaQueryData mediaQuery = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single);

// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
num FIGMA_DESIGN_WIDTH = 390;
num FIGMA_DESIGN_HEIGHT = 844;
num FIGMA_DESIGN_STATUS_BAR = 0;

///This extension is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
extension ResponsiveExtension on num {
  ///This method is used to get device viewport width.
  get _width {
    return mediaQuery.size.width;
  }

  ///This method is used to get device viewport height.
  get _height {
    num statusBar = mediaQuery.viewPadding.top;
    num bottomBar = mediaQuery.viewPadding.bottom;
    num screenHeight = mediaQuery.size.height - statusBar - bottomBar;
    return screenHeight;
  }

  ///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
  double get customWidth => ((this * _width) / FIGMA_DESIGN_WIDTH);

  ///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
  double get customHeight =>
      (this * _height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR);

  ///This method is used to set smallest px in image height and width
  double get adaptSize {
    var height = customHeight;
    var width = customWidth;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  ///This method is used to set text font size according to Viewport
  double get fSize => adaptSize;
}

extension FormatExtension on double {
  /// Return a [double] value with formatted according to provided fractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}
