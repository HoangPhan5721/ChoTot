import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:intern/core/utils/image_constant.dart';
import '../../../core/app_export.dart';
import '../models/cartitemlist_item_model.dart';
import '../models/my_cart_model.dart';

part 'my_cart_event.dart';

part 'my_cart_state.dart';

/// A bloc that manages the state of a MyCart according to the event that is dispatched to it.
class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  MyCartBloc(MyCartState initialState) : super(initialState) {
    on<MyCartInitialEvent>(_onInitialize);
  }

  _onInitialize(
    MyCartInitialEvent event,
    Emitter<MyCartState> emit,
  ) async {
    emit(
      state.copyWith(
        myCartModelObj: state.myCartModelObj?.copyWith(
          cartitemslistItemList: fillCartitemslistItemList(),
        ),
      ),
    );
  }

  List<CartitemslistItemModel> fillCartitemslistItemList() {
    return [
      CartitemslistItemModel(
          aloeVeraOne: ImageConstant.imgProduct1,
          aloevera: "lbl_aloe_vera".tr,
          loremipsum: "lbl_lorem_ipsum".tr,
          tf: "lbl".tr,
          one: "lbl_1".tr,
          one1: "lbl2".tr),
      CartitemslistItemModel(
          aloeVeraOne: ImageConstant.imgProduct2,
          aloevera: "lbl_pink_pot".tr,
          loremipsum: "lbl_lorem_ipsum".tr),
      CartitemslistItemModel(
          aloeVeraOne: ImageConstant.imgProduct3,
          aloevera: "lbl_globie".tr,
          loremipsum: "lbl_lorem_ipsum".tr),
      CartitemslistItemModel(
          aloeVeraOne: ImageConstant.imgProduct4,
          aloevera: "lbl_chew".tr,
          loremipsum: "lbl_lorem_ipsum".tr)
    ];
  }
}
