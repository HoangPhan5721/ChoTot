import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/post_bloc.dart';

import 'models/post_model.dart';

// ignore_for_file: must_be_immutable
class PostScreen extends StatelessWidget {
  PostScreen({Key? key})
      : super(
          key: key,
        );
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc(PostState(
        PostModelObj: PostModel(),
      ))
        ..add(PostInitialEvent()),
      child: PostScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 74.h),
                  _buildTitleInputSection(context),
                  SizedBox(height: 32.h),
                  _buildPassword(context),
                  SizedBox(height: 32.h),
                  _buildProductName(context),
                  SizedBox(height: 32.h),
                  _buildDescription(context),
                  SizedBox(height: 32.h),
                  // _buildErrorMessageSection(context),
                  // SizedBox(height: 32.h),
                  _buildPriceInputSection(context),
                  SizedBox(height: 32.h),
                  _buildLocationInputSection(context),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      "lbl_product_status".tr,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  _buildUsedRadioButton(context),
                  SizedBox(height: 32.h),
                  _buildNewRadioButton(context),
                  SizedBox(height: 54.h),
                  _buildCtaButtons(context)
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
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 67.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 37.h,
          top: 14.h,
          bottom: 11.h,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_post".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMoreVertical,
          margin: EdgeInsets.only(right: 25.h),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildInputfieldone(BuildContext context) {
    return BlocSelector<PostBloc, PostState, TextEditingController?>(
      selector: (state) => state.inputfieldoneController,
      builder: (context, inputfieldoneController) {
        return CustomTextFormField(
          controller: inputfieldoneController,
          hintText: "lbl_enter_title".tr,
          contentPadding: EdgeInsets.all(16.h),
          borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
          fillcolor: theme.colorScheme.primaryContainer,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildTitleInputSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_title".tr,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          _buildInputfieldone(context)
        ],
      ),
    );
  }
  // Widget _buildProductStatusSection(BuildContext context) {
  //   int status = 0; // 0: Used, 1: New
  //   return Container(
  //     width: double.maxFinite,
  //     margin: EdgeInsets.only(left: 6.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "lbl_product_status".tr,
  //           style: Theme.of(context).textTheme.labelLarge,
  //         ),
  //         SizedBox(height: 8),
  //         Row(
  //           children: [
  //             Radio<int>(
  //               value: 1,
  //               groupValue: status,
  //               onChanged: (int? value) {
  //                 setState(() {
  //                   status = value!;
  //                 });
  //               },
  //             ),
  //             Text("Used"),
  //             SizedBox(width: 16),
  //             Radio<int>(
  //               value: 0,
  //               groupValue: status,
  //               onChanged: (int? value) {
  //                 setState(() {
  //                   status = value!;
  //                 });
  //               },
  //             ),
  //             Text("New"),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  /// Section Widget
  Widget _buildCategoryInputSection(BuildContext context) {
    return BlocSelector<PostBloc, PostState, TextEditingController?>(
      selector: (state) => state.categoryInputSectionController,
      builder: (context, categoryInputSectionController) {
        return CustomTextFormField(
          controller: categoryInputSectionController,
          hintText: "lbl_enter_category".tr,
          contentPadding: EdgeInsets.all(16.h),
          borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
          fillcolor: theme.colorScheme.primaryContainer,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_category".tr,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          _buildCategoryInputSection(context)
        ],
      ),
    );
  }
  Widget _buildDescription(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_category".tr,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          _buildCategoryInputSection(context)
        ],
      ),
    );
  }
  Widget _buildProductName(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_category".tr,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          _buildCategoryInputSection(context)
        ],
      ),
    );
  }
  /// Section Widget
  Widget _buildDescriptionInputSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_description".tr,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          BlocSelector<PostBloc, PostState, TextEditingController?>(
            selector: (state) => state.inputfieldfiveController,
            builder: (context, inputfieldfiveController) {
              return CustomTextFormField(
                controller: inputfieldfiveController,
                hintText: "lbl_typing".tr,
                hintStyle: CustomTextStyles.bodyLargeOnPrimaryContainer,
                suffix: Container(
                  margin: EdgeInsets.fromLTRB(16.h, 16.h, 18.h, 16.h),
                  // child: CustomImageView(
                  //   imagePath: ImageConstant.imgArrowRight,
                  //   height: 22.h,
                  //   width: 24.h,
                  //   fit: BoxFit.contain,
                  // ),
                ),
                suffixConstraints: BoxConstraints(
                  maxHeight: 56.h,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18.h,
                  vertical: 16.h,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildErrorMessageSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          _buildDescriptionInputSection(context),
          // Text(
          //   "msg_error_message_informing".tr,
          //   style: theme.textTheme.bodySmall,
          // )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPricetwo(BuildContext context) {
    return BlocSelector<PostBloc, PostState, TextEditingController?>(
      selector: (state) => state.pricetwoController,
      builder: (context, pricetwoController) {
        return CustomTextFormField(
          controller: pricetwoController,
          hintText: "lbl_enter_price".tr,
          contentPadding: EdgeInsets.all(16.h),
          borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
          fillcolor: theme.colorScheme.primaryContainer,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildPriceInputSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_price".tr,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          _buildPricetwo(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLocationtwo(BuildContext context) {
    return BlocSelector<PostBloc, PostState, TextEditingController?>(
      selector: (state) => state.locationtwoController,
      builder: (context, locationtwoController) {
        return CustomTextFormField(
          controller: locationtwoController,
          hintText: "msg_enter_location".tr,
          textInputAction: TextInputAction.done,
          maxLines: 2,
          contentPadding: EdgeInsets.fromLTRB(16.h, 16.h, 16.h, 12.h),
          borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
          fillcolor: theme.colorScheme.primaryContainer,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildLocationInputSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_location".tr,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          _buildLocationtwo(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUsedRadioButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRadio,
            height: 24.h,
            width: 24.h,
            radius: BorderRadius.circular(
              12.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "lbl_used".tr,
              style: theme.textTheme.bodyLarge,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNewRadioButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRadio,
            height: 24.h,
            width: 24.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "lbl_new".tr,
              style: theme.textTheme.bodyLarge,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return CustomOutlinedButton(
      height: 56.h,
      width: 172.h,
      text: "lbl_cancel".tr,
      buttonTextStyle: CustomTextStyles.bodyLargeDeeppurpleA20001,
      onPressed: () {
        Navigator.pushNamed(context, '/personal_screen');
      },
    );
  }


  /// Section Widget
  Widget _buildPosttwo(BuildContext context) {
    return CustomElevatedButton(
      height: 56.h,
      width: 172.h,
      text: "lbl_post".tr,
      buttonStyle: CustomButtonStyles.fillBlueGray,
      buttonTextStyle: CustomTextStyles.bodyLargeOnPrimaryContainer,
    );
  }

  /// Section Widget
  Widget _buildCtaButtons(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildCancel(context), _buildPosttwo(context)],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {},
      ),
    );
  }
}
