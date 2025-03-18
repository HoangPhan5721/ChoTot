import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../providers/auth_provider.dart';

import 'package:logger/logger.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<ProductDetail> product;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    logger.i('Product ID: ${widget.productId}');
    product = fetchProduct(widget.productId);
  }
  // Hàm định dạng giá
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    try {
      return formatter.format(double.parse(price));
    } catch (e) {
      return price; // Trả về giá trị ban đầu nếu không thể định dạng
    }
  }
  Future<ProductDetail> fetchProduct(int id) async {
    final response = await http
        .get(Uri.parse('https://nodejs-cgor.onrender.com/api/posts/$id'));
    logger.i('Response status: ${response.statusCode}');
    logger.d('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final item = data['data'];
        return ProductDetail.fromJson(item);
      } else {
        throw Exception('Lỗi từ API: ${data['message']}');
      }
    } else {
      throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductDetail>(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(24)),
                      child: Image.network(
                        product.images.isNotEmpty ? product.images[0] : '',
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey);
                        },
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              formatCurrency(product.price),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF325A3E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Row(
                        //   children: [
                        //     const Icon(Icons.star,
                        //         color: Colors.amber, size: 22),
                        //     Text(
                        //       product.seller.rating.toString(),
                        //       style: const TextStyle(
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 12),
                        Row(
  crossAxisAlignment: CrossAxisAlignment.start, // Đảm bảo căn chỉnh trên cùng
  children: [
    const Icon(Icons.location_on, color: Color(0xFF325A3E), size: 22),
    const SizedBox(width: 4), // Khoảng cách giữa Icon và Text
    Expanded(
      child: Text(
        product.location,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.clip, // Không cắt nội dung
        softWrap: true, // Cho phép xuống dòng
      ),
    ),
  ],
),
                        const SizedBox(height: 12),
                        const Text(
                          "Thông tin chi tiết",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.description,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildMetric(Icons.star, product.seller.rating.toString(), 'Rating', Colors.yellow),
                                  
                              _buildMetric(Icons.thermostat,
                                  product.productStatus, 'Status', Color(0xFF325A3E)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.call,
                                    color: Color(0xFF325A3E), size: 28),
                                onPressed: () {
                                  // Add call functionality
                                },
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    final token = Provider.of<AuthProvider>(context, listen: false).token;
                                    if (token == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Bạn chưa đăng nhập!")),
                                      );
                                      return;
                                    }
                                    
                                    Navigator.pushNamed(
                                      context,
                                      "/chat_screen",
                                      arguments: {
                                        'token': token, // ✅ Pass token
                                        'sellerId': product.userId,
                                        'sellerName': product.seller.name,
                                        'profileImage': product.seller.avatarUrl,
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF325A3E),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    '💬 Chat',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }

  Widget _buildMetric(IconData icon, String value, String label, Color iconColor) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }
}

class ProductDetail {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String productStatus;
  final String price;
  final String location;
  final List<String> images;
  final Seller seller;

  ProductDetail({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.productStatus,
    required this.price,
    required this.location,
    required this.images,
    required this.seller,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      title: json['title'] ?? 'Không có tiêu đề',
      description: json['description'] ?? 'Không có mô tả',
      productStatus: json['product_status'] ?? 'Không xác định',
      price: json['price'] ?? '0',
      location: json['location'] ?? 'Không có địa điểm',
      images: (json['images'] as List?)
              ?.map((img) => img['image_url'] as String? ?? '')
              .toList() ??
          [],
      seller: Seller.fromJson(json['User']['UserInfo'] ?? {}),
    );
  }
}

class Seller {
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final double rating;

  Seller({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.rating,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      name: json['name'] ?? 'Không có tên',
      email: json['email'] ?? 'Không có email',
      phone: json['phone'] ?? 'Không có số điện thoại',
      avatarUrl: json['avatar_url'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
