import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/personal_bloc.dart';
import 'models/personal_model.dart'; // ignore_for_file: must_be_immutable
import '../../widgets/custom_bottom_bar.dart';
class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<PersonalBloc>(
      create: (context) => PersonalBloc(PersonalState(
        PersonalModelObj: PersonalModel(),
      ))
        ..add(PersonalInitialEvent()),
      child: PersonalPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalBloc, PersonalState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.primaryContainer,
          appBar: _buildAppBar(context),
          body: SafeArea(
            top: false,
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgAvatar,
                        height: 154.h,
                        width: 160.h,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "lbl_puerto_rico".tr,
                        style: CustomTextStyles.titleLargePoppinsBlack900,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "msg_youremail_domain_com".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 42.h),
                      _buildProfileInfoColumn(context),
                      SizedBox(height: 28.h),
                      _buildSettingsColumn(context),
                      SizedBox(height: 28.h),
                      _buildSupportInfoColumn(context),
                      SizedBox(height: 12.h)
                    ],
                  ),
                ),
              ),
            ),

          ),
          bottomNavigationBar: SizedBox(
            width: double.maxFinite,
            child: _buildBottomBar(context),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 50.h,
      leadingWidth: 40.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 10.h,
          top: 10.h,
          bottom: 10.h,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMoreVertical,
          margin: EdgeInsets.only(right: 52.h),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildProfileInfoColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 16.h,
      ),
      decoration: AppDecoration.lightGray0.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        // spacing: 18,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: _buildSecurityRow(
              context,
              linebusinessp: ImageConstant.imgLineBusinessProfileLine,
              editprofile: "msg_edit_profile_information".tr,
            ),
          ),
          SizedBox(height: 18),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgLineMediaNoti,
                        height: 24.h,
                        width: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.h),
                        child: Text(
                          "lbl_notifications".tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "lbl_on".tr,
                  style: CustomTextStyles.bodyMediumBlueA400,
                )
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgLineEditorTranslate2,
                        height: 24.h,
                        width: 24.h,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.h),
                          child: Text(
                            "lbl_language".tr,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "lbl_english".tr,
                    style: CustomTextStyles.bodyMediumBlueA400,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSettingsColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 16.h,
      ),
      decoration: AppDecoration.lightGray0.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        // spacing: 16,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(

            width: double.maxFinite,
            child: _buildSecurityRow(
              context,
              linebusinessp: ImageConstant.imgLineBusinessP,
              editprofile: "lbl_security".tr,
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgLineHealthMen,
                        height: 24.h,
                        width: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.h),
                        child: Text(
                          "lbl_theme".tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "lbl_light_mode".tr,
                    style: CustomTextStyles.bodyMediumBlueA400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 2.h)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSupportInfoColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 16.h,
      ),
      decoration: AppDecoration.lightGray0.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        // spacing: 18,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: _buildSecurityRow(
              context,
              linebusinessp: ImageConstant.imgLineUserContactsLine,
              editprofile: "lbl_help_support".tr,
            ),
          ),
          SizedBox(height: 18),
          SizedBox(
            width: double.maxFinite,
            child: _buildSecurityRow(
              context,
              linebusinessp: ImageConstant.imgLineCommunicat,
              editprofile: "lbl_contact_us".tr,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: _buildSecurityRow(
              context,
              linebusinessp: ImageConstant.imgLineSystemLock2Line,
              editprofile: "lbl_privacy_policy".tr,
            ),
          )
        ],
      ),
    );
  }
  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {},
      ),
    );
  }
  /// Common widget
  Widget _buildSecurityRow(
    BuildContext context, {
    required String linebusinessp,
    required String editprofile,
  }) {
    return Row(
      children: [
        CustomImageView(
          imagePath: linebusinessp,
          height: 24.h,
          width: 24.h,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              editprofile,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        )
      ],
    );
  }
}
