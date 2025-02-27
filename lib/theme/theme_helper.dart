import 'package:flutter/material.dart';
import 'package:intern/core/app_export.dart';
import 'package:intern/core/utils/pref_utils.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable
class ThemeHelper {
// The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.lightGreen400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          // shadowColor: appTheme.black900.withValues (
          //   alpha: 0.25,
          // ),
          shadowColor: appTheme.black900.withAlpha(1),
          elevation: 4,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        side: BorderSide(
          width: 1,
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 2,
        space: 2,
        color: appTheme.gray50005,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodySmall: TextStyle(
          color: appTheme.gray40001,
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 50.fSize,
          fontFamily: 'Breadbary',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 35.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: appTheme.blueGray70001,
          fontSize: 24.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: appTheme.gray800,
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.primaryContainer,
          fontSize: 20.fSize,
          fontFamily: 'Helvetica',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: appTheme.blueGray70001,
          fontSize: 16.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      );
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF325A3D),
    primaryContainer: Color(0XFFFFFFFFF),
    onError: Color(0XFF384A40),
    onPrimary: Color(0XFF060606),
    onPrimaryContainer: Color(0XFF284130),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
// Black
  Color get black900 => Color(0XFF000000);

// BlueGray
  Color get blueGray100 => Color(0XFFD9D9D9);

  Color get blueGray10001 => Color(0XFFD3D5D3);

  Color get blueGray400 => Color(0XFF8A8A8A);

  Color get blueGray40001 => Color(0XFF8C9691);

  Color get blueGray700 => Color(0XFF4D6E5C);

  Color get blueGray70001 => Color(0XFF3B7254);

  Color get blueGray70002 => Color(0XFF3A7154);

  Color get blueGray800 => Color(0XFF325A3E);

// Gray
  Color get gray200 => Color(0XFFF0F0F0);

  Color get gray20001 => Color(0XFFEFEAEA);

  Color get gray20002 => Color(0XFFEEEEEE);

  Color get gray300 => Color(0XFFE0E5E2);

  Color get gray400 => Color(0XFFBCB9B9);

  Color get gray40001 => Color(0XFFBDB6B6);

  Color get gray4007f => Color(0X7FB6B9B7);

  Color get gray500 => Color(0XFF999797);

  Color get gray50001 => Color(0XFFA5A5A5);

  Color get gray50002 => Color(0XFF999999);

  Color get gray50003 => Color(0XFFA5AFA8);

  Color get gray50004 => Color(0XFF9D9999);

  Color get gray50005 => Color(0XFF9D9D9D);

  Color get gray800 => Color(0XFF33493A);

// Gree
  Color get green200A3 => Color(0XA3B1D3A1);

// Green
  Color get green400 => Color(0XFF67CE67);

  Color get green40087 => Color(0X8776885F);

  Color get green50 => Color(0XFFE8F5EE);

  Color get greenA700 => Color(0XFF14BE61);

// LightGreen
  Color get lightGreen100 => Color(0XFFE2FFD1);

  Color get lightGreen400 => Color(0XFF81D065);

  Color get lightGreen900 => Color(0XFF3A7F0D);
}
