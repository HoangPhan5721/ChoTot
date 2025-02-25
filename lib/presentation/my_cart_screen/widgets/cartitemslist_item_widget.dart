import 'package:flutter/material.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../models/cartitemlist_item_model.dart';

// ignore_for_file: must_be_immutable
class CartitemslistItemWidget extends StatelessWidget {
  CartitemslistItemWidget(this.cartitemslistItemModelObj, {Key? key})
      : super(
          key: key,
        );
  CartitemslistItemModel cartitemslistItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 8.h,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: cartitemslistItemModelObj.aloeVeraOne!,
            height: 66.h,
            width: 66.h,
            radius: BorderRadius.circular(
              5.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartitemslistItemModelObj.aloevera!,
                  style: theme.textTheme.headlineSmall,
                ),
                Text(
                  cartitemslistItemModelObj.loremipsum!,
                  style: CustomTextStyles.titleSmallGray50004,
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              cartitemslistItemModelObj.tf!,
                              style: theme.textTheme.titleSmall,
                            ),
                            Container(
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  5.h,
                                ),
                                border: Border.all(
                                  color: appTheme.lightGreen900,
                                  width: 1.h,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.h),
                        child: Text(
                          cartitemslistItemModelObj.one!,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Container(
                        height: 20.h,
                        width: 20.h,
                        margin: EdgeInsets.only(left: 12.h),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.h),
                                child: Text(
                                  cartitemslistItemModelObj.one1!,
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
                            ),
                            Container(
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  5.h,
                                ),
                                border: Border.all(
                                  color: appTheme.lightGreen900,
                                  width: 1.h,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          _buildAloeVeraPriceButton(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAloeVeraPriceButton(BuildContext context) {
    return CustomElevatedButton(
      width: 66.h,
      text: "lbl_20".tr,
      margin: EdgeInsets.only(bottom: 16.h),
      alignment: Alignment.bottomCenter,
    );
  }
}
