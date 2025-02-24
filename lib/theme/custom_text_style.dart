import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'theme_helper.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
// Display text style
  static TextStyle get displayMediumInterOnPrimary =>
      theme.textTheme.displayMedium!.inter
          .copyWith(color: theme.colorScheme.onPrimary);

  static TextStyle get displayMediumPrimary =>
      theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

// Headline text style
  static TextStyle get headlineSmallBlack900 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontSize: 25.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headlineSmallBlack900Bold =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontSize: 25.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headlineSmallGray800 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.gray800,
      );

  static TextStyle get headlineSmallGreenA700 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.greenA700,
        fontSize: 25.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headlineSmallPoppinsBlack900 =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get headlineSmallPrimary =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary,
      );

  static TextStyle get headlineSmallSemiBold =>
      theme.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );

// Label text style
  static TextStyle get labelLargeBluegray800 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray800,
      );

  static TextStyle get labelLargeGray50002 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray50002,
      );

  static TextStyle get labelLargePrimary =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelLargePrimaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );

// Title text style
  static TextStyle get titleLargeInter =>
      theme.textTheme.titleLarge!.inter.copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleLargeInterBlack900 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleLargeInterGray50003 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.gray50003,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleLargeInterGray800 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.gray800,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleMediumBluegray40001 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray40001,
      );

  static TextStyle get titleMediumBluegray70002 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray70002,
      );

  static TextStyle get titleMediumBluegray800 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray800,
      );

  static TextStyle get titleMediumLightgreen900 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.lightGreen900,
      );

  static TextStyle get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );

  static TextStyle get titleMediumPoppinsBlack900 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );

  static TextStyle get titleMediumSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmallBluegray400 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray400,
      );
  static TextStyle get titleSmallGreen300 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.lightGreen900,
      );
  static TextStyle get titleSmallBluegray70001 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray70001,
      );

  static TextStyle get titleSmallGray500 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray500,
      );

  static TextStyle get titleSmallGray50004 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray50004,
      );

  static TextStyle get titleSmallGray800 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray800,
      );

  static TextStyle get titleSmallonError =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onError,
      );

  static TextStyle get titleSmallPoppinsGray50001 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.gray50001,
        fontWeight: FontWeight.w700,
      );
}
