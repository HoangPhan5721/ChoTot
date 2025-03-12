class PostModel {
  String? title;
  int? categoryId;
  String? productName;
  String? description;
  String? price;
  String? location;
  String? status;
  String? imagePath; // Add this field
  PostModel({
    this.title,
    this.categoryId,
    this.productName,
    this.description,
    this.price,
    this.location,
    this.status,
    this.imagePath, // Add to constructor
  });

  PostModel copyWith({
    String? title,
    int? categoryId,
    String? productName,
    String? description,
    String? price,
    String? location,
    String? status,
    String? imagePath,
  }) {
    return PostModel(
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      price: price ?? this.price,
      location: location ?? this.location,
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath, // Add to return statement
    );
  }
}
