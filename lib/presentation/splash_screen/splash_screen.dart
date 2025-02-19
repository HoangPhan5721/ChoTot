import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import 'bloc/splash_bloc.dart';
import 'models/splash_model.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
    key: key,
  );

  static Widget builder(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) =>
      SplashBloc(SplashState(splashModelObj: SplashModel(),))
        ..add(SplashInitialEvent()), child: SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.lightGreen100,
            body: SafeArea(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 62.h, top: 252.h,),

                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgVector,
                      height: 228.h,
                      width: 276.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children:
                          [
                            TextSpan(
                              text: "lbl_smart".tr,
                              style: CustomTextStyles.headlineSmallBlack900,
                            ),
                            TextSpan(
                              text: "lbl market".tr,
                              style: CustomTextStyles.headlineSmallGreenA700,
                            )
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}