import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton_two.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '/../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/my_cart_bloc.dart';
import 'models/cartitemlist_item_model.dart';
import 'models/my_cart_model.dart';
import 'widgets/cartitemslist_item_widget.dart';
import '../../widgets/custom_bottom_bar.dart';
class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<MyCartBloc>(
      create: (context) => MyCartBloc(MyCartState(
        myCartModelObj: MyCartModel(),
      ))
        ..add(MyCartInitialEvent()),
      child: MyCartScreen(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 28.h),
            Expanded(
              child: SingleChildScrollView(
                child: _buildCartItemsList(context),
              ),
            ),
            // _buildOrderSummary(context), // Fixed at the bottom
          ],
        ),
      ),
            bottomNavigationBar:
            SizedBox(
            width: double.maxFinite,
            child: _buildBottomBar(context),
            )
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
  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 55.h,
      leading: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/post_screen');
        },
        child: AppbarLeadingIconbuttonTwo(
          imagePath: ImageConstant.imgArrowLeft,
          margin: EdgeInsets.only(
            left: 25.h,
            top: 12.h,
            bottom: 13.h,
          ),
        ),
      ),
      title: AppbarTitle(
        text: "lbl_my_post".tr,
        margin: EdgeInsets.only(left: 100.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMoreVertical,
          margin: EdgeInsets.only(right: 28.h),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildCartItemsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.h),
      child: BlocSelector<MyCartBloc, MyCartState, MyCartModel?>(
        selector: (state) => state.myCartModelObj,
        builder: (context, myCartModelObj) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 28.h,
              );
            },
            itemCount: myCartModelObj?.cartitemslistItemList.length ?? 0,
            itemBuilder: (context, index) {
              CartitemslistItemModel model =
                  myCartModelObj?.cartitemslistItemList[index] ??
                      CartitemslistItemModel();
              return CartitemslistItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildPlaceOrderButton(BuildContext context) {
    return CustomElevatedButton(
      height: 50.h,
      text: "msg_place_your_order".tr,
      buttonStyle: CustomButtonStyles.outlineBlack,
      buttonTextStyle: CustomTextStyles.titleMediumPrimaryContainer,
      onPressed: () {
        Navigator.pushNamed(context, '/post_screen');
      },
    );
  }


  /// Section Widget
  Widget _buildOrderSummary(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 50.h,
      ),
      decoration: AppDecoration.outlineBlack9002.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 22.h,
              right: 28.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl_subtotal".tr,
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  "lbl_100_00".tr,
                  style: theme.textTheme.titleMedium,
                )
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 22.h,
              right: 36.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "msg_shipping_charges".tr,
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  "lbl_70_00".tr,
                  style: theme.textTheme.titleMedium,
                )
              ],
            ),
          ),
          SizedBox(height: 38.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              indent: 22.h,
              endIndent: 18.h,
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 22.h,
              right: 30.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl_total".tr,
                  style: CustomTextStyles.titleMediumPoppinsBlack900,
                ),
                Text(
                  "lbl_170_00".tr,
                  style: CustomTextStyles.titleMediumPoppinsBlack900,
                )
              ],
            ),
          ),
          SizedBox(height: 32.h),
          _buildPlaceOrderButton(context),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }
}
