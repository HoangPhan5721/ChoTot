class Product {
  final int id;
  final String title;
  final String price;
  final String location;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      price: json['price'] ?? '0',
      location: json['location'] ?? 'Unknown',
      images: (json['images'] as List?)
          ?.map((img) => img['image_url'] as String? ?? '')
          .toList() ?? [],
    );
  }
}
