import 'package:flutter/material.dart';
import 'package:intern/core/app_export.dart';


class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray =>
      BoxDecoration(color: appTheme.blueGray100);

  static BoxDecoration get fillBluegray10001 =>
      BoxDecoration(color: appTheme.blueGray10001);

  static BoxDecoration get fillBluegray70001 =>
      BoxDecoration(color: appTheme.blueGray70001);

  static BoxDecoration get fillGray =>
      BoxDecoration(color: appTheme.gray200);

  static BoxDecoration get fillGreenA =>
      BoxDecoration(color: appTheme.green200A3);

  static BoxDecoration get fillLightGreen =>
      BoxDecoration(color: appTheme.lightGreen100);

  static BoxDecoration get fillPrimaryContainer =>
      BoxDecoration(color: theme.colorScheme.primaryContainer);

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
    color: appTheme.greenA700,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.25),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get outlineBlack900 => BoxDecoration(
    color: theme.colorScheme.primaryContainer,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.25),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get outlineBlack9001 => BoxDecoration(
    color: appTheme.green50,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.25),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 7),
      ),
    ],
  );

  static BoxDecoration get outlineBlack9002 => BoxDecoration(
    color: theme.colorScheme.primaryContainer,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.25),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get outlineBlueGray => BoxDecoration(
    color: appTheme.gray200,
    border: Border.all(
      color: appTheme.blueGray800,
      width: 2.h,
    ),
  );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.h);
  static BorderRadius get roundedBorder14 => BorderRadius.circular(14.h);
  static BorderRadius get roundedBorder30 => BorderRadius.circular(30.h);
  static BorderRadius get roundedBorder5 => BorderRadius.circular(5.h);
  static BorderRadius get roundedBorder50 => BorderRadius.circular(50.h);
}
