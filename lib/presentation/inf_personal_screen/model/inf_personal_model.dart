class InfPersonalModel {
  String email;
  String name;
  String address;
  String phone;
  double rating;
  String avatarUrl;

  InfPersonalModel({
    this.email = "nguyen29082003@gmail.com",
    this.name = "",
    this.address = "",
    this.phone = "",
    this.rating = 0.0,
    this.avatarUrl = "",
  });

  factory InfPersonalModel.fromJson(Map<String, dynamic> json) {
    return InfPersonalModel(
      email: json['email'] ?? "",
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      phone: json['phone'] ?? "",
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      avatarUrl: json['avatar_url'] ?? "",
    );
  }
}
