import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import 'cartitemlist_item_model.dart';
/// This class defines the variables used in the [my_cart_screen],
/// and is typically used to hold data that is passed between different parts of the application
// ignore_for_file: must_be_immutable
class MyCartModel extends Equatable {
  MyCartModel({this.cartitemslistItemList = const []});
  List<CartitemslistItemModel> cartitemslistItemList;
  MyCartModel copyWith({List<CartitemslistItemModel>? cartitemslistItemList}) {
    return MyCartModel(
      cartitemslistItemList:
      cartitemslistItemList ?? this.cartitemslistItemList,
    );
  }
  @override
  List<Object?> get props => [cartitemslistItemList];
}