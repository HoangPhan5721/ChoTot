import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillGreen => BoxDecoration(
    color: appTheme.green40087,
    borderRadius: BorderRadius.circular(14.h),
  );

  static BoxDecoration get fillBlueGray => BoxDecoration(
    color: appTheme.blueGray100,
    borderRadius: BorderRadius.circular(20.h),
  );

  static BoxDecoration get fillGray => BoxDecoration(
    color: appTheme.gray20001,
    borderRadius: BorderRadius.circular(20.h),
  );

  static BoxDecoration get outlineBlack => BoxDecoration(
    color: appTheme.blueGray70001,
    borderRadius: BorderRadius.circular(24.h),
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.25),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get outlineBlackTL24 => BoxDecoration(
    color: appTheme.gray20002,
    borderRadius: BorderRadius.circular(24.h),
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.25),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get none => const BoxDecoration();
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.decoration,
    this.padding,
    this.onTap,
    this.child,
  }) : super(key: key);

  final Alignment? alignment;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: iconButtonWidget,
    )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
    height: height ?? 0,
    width: width ?? 0,
    child: DecoratedBox(
      decoration: decoration ??
          BoxDecoration(
            color: appTheme.gray20001,
            borderRadius: BorderRadius.circular(14.h),
          ),
      child: IconButton(
        padding: padding ?? EdgeInsets.zero,
        onPressed: onTap,
        icon: child ?? Container(),
      ),
    ),
  );
}
