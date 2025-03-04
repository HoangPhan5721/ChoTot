import 'package:equatable/equatable.dart';
import 'package:intern/core/utils/image_constant.dart';
import '../../../core/app_export.dart';
/// This class is used in the [cartitemslist_item_widget] screen.
// ignore_for_file: must_be_immutable
class CartitemslistItemModel extends Equatable {
  CartitemslistItemModel(
      {this.aloeVeraOne,
        this.aloevera,
        this.loremipsum,
        this.tf,
        this.one,
        this.one1,
        this.id}) {
    aloeVeraOne = aloeVeraOne ?? ImageConstant.imgProduct1;
    aloevera = aloevera ?? "lbl_aloe_vera".tr;
    loremipsum = loremipsum ?? "lbl_lorem_ipsum".tr;
    tf = tf ?? "lbl".tr;
    one = one ?? "lbl_1".tr;
    one1 = one1 ?? "lbl_2".tr;
    id = id ?? "";
  }
  String? aloeVeraOne;
  String? aloevera;
  String? loremipsum;
  String? tf;
  String? one;

  String? one1;
  String? id;
  CartitemslistItemModel copyWith({
    String? aloeVeraOne,
    String? aloevera,
    String? loremipsum,
    String? tf,
    String? one,
    String? one1,
    String? id,
  }) {
    return CartitemslistItemModel(
      aloeVeraOne: aloeVeraOne ?? this.aloeVeraOne,
      aloevera: aloevera ?? this.aloevera,
      loremipsum: loremipsum ?? this.loremipsum,
      tf: tf ?? this.tf,
      one: one ?? this.one,
      one1: one1 ?? this.one1,
      id: id ?? this.id,
    );
  }
  @override
  List<Object?> get props =>
      [aloeVeraOne, aloevera, loremipsum, tf, one, one1, id];
}