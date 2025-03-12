import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';

class CartitemslistItemModel extends Equatable {
  final int? id; // Added for API's "id"
  final String? title;
  final String? image; // Changed to String? for image_url
  final String? price;
  final String? categoryId;
  final String? location;
  final String? idUser;

  CartitemslistItemModel({
    this.id,
    this.title = "lbl_lorem_ipsum",
    this.image,
    this.price = "lbl_lorem_ipsum",
    this.categoryId = "3",
    this.location = "lbl_1",
    this.idUser = "1",
  });

  CartitemslistItemModel copyWith({
    int? id,
    String? title,
    String? image,
    String? price,
    String? categoryId,
    String? location,
    String? idUser,
  }) {
    return CartitemslistItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      location: location ?? this.location,
      idUser: idUser ?? this.idUser,
    );
  }

  // Factory method to create from JSON
  factory CartitemslistItemModel.fromJson(Map<String, dynamic> json) {
    return CartitemslistItemModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      image: (json['images'] as List?)?.isNotEmpty == true
          ? json['images'][0]['image_url'] as String?
          : null, // Take first image URL if available
      price: json['price'] as String?,
      categoryId: (json['category_id'] as int?)?.toString(), // Convert int to String
      location: json['location'] as String?,
      idUser: (json['user_id'] as int?)?.toString(), // Convert int to String
    );
  }

  @override
  List<Object?> get props => [id, idUser, categoryId, title, image, price, location];
}
