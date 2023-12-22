import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_export.dart';
import '../core/utlis/pref_utils.dart';

/// Helper class for managing themes and colors.
class ThemeHelper {
  // The current app theme
  final _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  final Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [newTheme].
  void changeTheme(String newTheme) {
    PrefUtils().setThemeData(newTheme);
    Get.forceAppUpdate();
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;

    return ThemeData(
      fontFamily: 'Poppins',
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.red20003,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0.0,
        backgroundColor: appTheme.red30003,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: appTheme.gray400,
        iconTheme: IconThemeData(
          color: appTheme.gray80001,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: appTheme.gray5000a,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
          color: appTheme.gray80001,
          fontWeight: FontWeight.w500,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: appTheme.orange50,
            width: 1.customWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.customWidth),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: appTheme.orange50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(42.customWidth),
              topRight: Radius.circular(42.customWidth),
              bottomLeft: Radius.circular(42.customWidth),
              bottomRight: Radius.circular(42.customWidth),
            ),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 0.5,
        space: 1,
        color: appTheme.gray80001.withOpacity(0.49),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStatePropertyAll(
          appTheme.gray80001,
        ),
        side: BorderSide(
          width: 2.0,
          color: appTheme.orange50,
        ),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 8.0.customHeight,
        overlayShape: SliderComponentShape.noThumb,
        tickMarkShape: SliderTickMarkShape.noTickMark,
        activeTrackColor: appTheme.gray700,
        inactiveTrackColor: appTheme.gray800,
        thumbColor: appTheme.gray90001,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.orange50,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.orange50,
          fontSize: 10.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: appTheme.orange50,
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: appTheme.gray80001,
          fontSize: 10.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: appTheme.orange50,
          fontSize: 16.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: appTheme.gray80001,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light();
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // DeepOrange
  Color get deepOrange200 => const Color(0XFFEFB68A);
  Color get deepOrange20001 => const Color(0XFFEFB296);

  // Gray
  Color get gray400 => const Color(0XFFDDBEA9);
  Color get gray40001 => const Color(0XFFDDBBA7);
  Color get gray500 => const Color(0XFFC29680);
  Color get gray600 => const Color(0XFF898F7A);
  Color get gray700 => const Color(0XFF606655);
  Color get gray70001 => const Color(0XFF6A705D);
  Color get gray70002 => const Color(0XFF5C6151);
  Color get gray800 => const Color(0XFF3F4239);
  Color get gray80001 => const Color(0XFF3F4238);
  Color get gray900 => const Color(0XFF191919);
  Color get gray90001 => const Color(0XFF1F2024);

  // Graya
  Color get gray5000a => const Color(0X0AA4A58D);

  // Orange
  Color get orange50 => const Color(0XFFFFE8D6);

  // Pink
  Color get pink900 => const Color(0XFF8F0D55);

  // Red
  Color get red200 => const Color(0XFFD6A891);
  Color get red20001 => const Color(0XFFD6A993);
  Color get red20002 => const Color(0XFFE1A98F);
  Color get red20003 => const Color(0XFFDA9A97);
  Color get red20004 => const Color(0XFFD8B5A0);
  Color get red20005 => const Color(0XFFD3AE99);
  Color get red20026 => const Color(0X26E2B29A);
  Color get red300 => const Color(0XFFBB8C75);
  Color get red30001 => const Color(0XFFC9967D);
  Color get red30002 => const Color(0XFFC3947E);
  Color get red30003 => const Color(0XFFB98B73);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
