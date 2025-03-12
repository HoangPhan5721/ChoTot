import 'package:flutter/material.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../../core/app_export.dart';
import '../models/cartitemlist_item_model.dart';

// ignore_for_file: must_be_immutable
class CartitemslistItemWidget extends StatelessWidget {
  CartitemslistItemWidget(this.cartitemslistItemModelObj, {Key? key})
      : super(key: key);

  CartitemslistItemModel cartitemslistItemModelObj;

  // Format price (limit to 5 digits & add commas)
  String formatPrice(String? price) {
    if (price == null) return "N/A";
    try {
      final number = double.parse(price);
      final formattedNumber = number.toStringAsFixed(0);

      // Keep first 5 digits
      String shortened = formattedNumber.length > 5
          ? formattedNumber.substring(0, 5)
          : formattedNumber;

      // Add commas for readability
      return "${shortened.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
      )} VND";
    } catch (e) {
      return price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.h),
      padding: EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6.h,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.h),
            child: CustomImageView(
              imagePath: cartitemslistItemModelObj.image,
              height: 70.h,
              width: 70.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.h),
          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  cartitemslistItemModelObj.title ?? 'No title',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.h,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                // Location with Icon
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16.h, color: Colors.grey),
                    SizedBox(width: 4.h),
                    Expanded(
                      child: Text(
                        cartitemslistItemModelObj.location ?? 'No location',
                        style: CustomTextStyles.titleSmallGray50004?.copyWith(
                          fontSize: 14.h,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Price Label
                Text(
                  formatPrice(cartitemslistItemModelObj.price),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: appTheme.blueBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
