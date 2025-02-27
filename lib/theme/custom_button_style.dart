import 'package:flutter/material.dart';
import 'package:intern/core/app_export.dart';
import 'theme_helper.dart';
/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
// Filled button style
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
      backgroundColor: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(28.h),
  ),
  elevation: 0,
  padding: EdgeInsets.zero,
  );
  static ButtonStyle get fillPrimaryTL32 => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.primary,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.h),
  ),
  elevation: 0,
  padding: EdgeInsets.zero,
  );
// Outline button style
  static ButtonStyle get outlineBlack => ElevatedButton.styleFrom(
      backgroundColor: appTheme.blueGray70002,
      shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.h),
  ),
  // shadowColor: appTheme.black900.withValues (
  // alpha: 0.25,
  // ),
    shadowColor: appTheme.black900.withAlpha (
      1
    ),
  elevation: 7,
  padding: EdgeInsets.zero,
  );

  // text button style
  static ButtonStyle get none => ButtonStyle(
  backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
  elevation: WidgetStateProperty.all<double>(0),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
  side: WidgetStateProperty.all<BorderSide>(
  BorderSide (color: Colors.transparent),
  ));
}