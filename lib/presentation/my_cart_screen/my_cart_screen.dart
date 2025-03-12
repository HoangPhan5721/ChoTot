import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton_two.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/my_cart_bloc.dart';
import 'models/cartitemlist_item_model.dart';
import 'models/my_cart_model.dart';
import 'widgets/cartitemslist_item_widget.dart';
import '../../widgets/custom_bottom_bar.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<MyCartBloc>(
      create: (context) => MyCartBloc(MyCartState(
        myCartModelObj: MyCartModel(), // Initialized with an empty model
      ))
        ..add(MyCartInitialEvent()),
      child: const MyCartScreen(),
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
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.maxFinite,
        child: _buildBottomBar(context),
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

  Widget _buildCartItemsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: BlocSelector<MyCartBloc, MyCartState, MyCartModel?>(
        selector: (state) => state.myCartModelObj,
        builder: (context, myCartModelObj) {
          // Safely handle nullability by providing a default empty list
          final cartItems = myCartModelObj?.cartitemslistItemList ?? [];
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 28.h);
            },
            itemCount: cartItems.length, // Safe now, as cartItems is never null
            itemBuilder: (context, index) {
              CartitemslistItemModel model = cartItems[index]; // Safe access
              return CartitemslistItemWidget(model);
            },
          );
        },
      ),
    );
  }
}
