import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:logger/logger.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  final String? token; // Add token field

  const ProductDetailScreen({super.key, required this.productId, this.token});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<ProductDetail> product;
  late Future<List<Review>> reviews;
  final Logger logger = Logger();
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    logger.i('Product ID: ${widget.productId}');
    product = fetchProduct(widget.productId);
    reviews = fetchReviews();
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    try {
      return formatter.format(double.parse(price));
    } catch (e) {
      return price;
    }
  }

  Future<ProductDetail> fetchProduct(int id) async {
    try {
      final response = await http.get(Uri.parse('https://nodejs-cgor.onrender.com/api/posts/detail/$id'));
      logger.i('Response status: ${response.statusCode}');
      logger.d('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('API returned an empty response');
        }

        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          if (data['success'] == true) {
            final item = data['data'];
            if (item != null) {
              return ProductDetail.fromJson(item);
            } else {
              throw Exception('No product data found in response');
            }
          } else {
            throw Exception('API error: ${data['message'] ?? 'Unknown error'}');
          }
        } else {
          throw Exception('Invalid JSON format: Expected a Map');
        }
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error fetching product: $e');
      rethrow; // Re-throw the exception to be caught by FutureBuilder
    }
  }

  Future<List<Review>> fetchReviews() async {
    final response = await http.get(Uri.parse('https://nodejs-cgor.onrender.com/api/reviews'));
    logger.i('Reviews response status: ${response.statusCode}');
    logger.d('Reviews response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 200) {
        List<dynamic> reviewList = data['metadata'];
        return reviewList.map((json) => Review.fromJson(json)).toList();
      } else {
        throw Exception('Lỗi từ API: ${data['message']}');
      }
    } else {
      throw Exception('Lỗi khi tải đánh giá: ${response.statusCode}');
    }
  }

  Future<void> postReview(int sellerId, String title, String content, int rating) async {
    final url = Uri.parse('https://nodejs-cgor.onrender.com/api/reviews');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (widget.token != null) 'Authorization': 'Bearer ${widget.token}', // Add token if required
      },
      body: jsonEncode({
        'sellerId': sellerId,
        'reviewerId': 2, // Replace with actual reviewer ID
        'reviewTitle': title,
        'content': content,
        'rating': rating,
      }),
    );

    logger.i('Post review status: ${response.statusCode}');
    logger.d('Post review response: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      setState(() {
        reviews = fetchReviews();
      });
    } else {
      throw Exception('Lỗi khi gửi đánh giá: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Existing build method remains unchanged until _buildReviewInput
    return Scaffold(
      body: FutureBuilder<ProductDetail>(
        future: product,
        builder: (context, productSnapshot) {
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (productSnapshot.hasError) {
            return Center(child: Text('Lỗi: ${productSnapshot.error}'));
          } else if (productSnapshot.hasData) {
            final product = productSnapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                        child: Image.network(
                          product.images.isNotEmpty ? product.images[0] : '',
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                          },
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFF325A3E), size: 22),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                product.location,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Thông tin chi tiết",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.description,
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildMetric(Icons.star, product.seller.rating.toString(), 'Rating', Colors.yellow),
                              _buildMetric(Icons.thermostat, product.productStatus, 'Status', const Color(0xFF325A3E)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.call, color: Color(0xFF325A3E), size: 28),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (widget.token == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Please log in to access chat')),
                                      );
                                      return;
                                    }
                                    Navigator.pushNamed(
                                      context,
                                      '/chat_screen',
                                      arguments: {
                                        'token': widget.token,
                                        'sellerId': product.seller.id.toString(), // Use product.seller.id
                                        'sellerName': product.seller.name ?? 'Unknown Seller', // Use product.seller.name
                                        'profileImage': product.seller.avatarUrl ?? '', // Use product.seller.avatarUrl
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF325A3E),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text(
                                    '💬 Chat',
                                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildReviewSection(context, product.userId), // Add review section
                      ],
                    ),
                  ),
                ],
              ),
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
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    );
  }

  Widget _buildReviewSection(BuildContext context, int sellerId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Đánh giá",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<Review>>(
          future: reviews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Lỗi khi tải đánh giá: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final reviewList = snapshot.data!.where((review) => review.sellerId == sellerId).toList();
              return Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: reviewList.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(review: reviewList[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReviewInput(context, sellerId), // Pass sellerId to input
                ],
              );
            } else {
              return const Text('Chưa có đánh giá nào');
            }
          },
        ),
      ],
    );
  }

  Widget _buildReviewInput(BuildContext context, int sellerId) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: reviewController,
            decoration: InputDecoration(
              hintText: 'Viết đánh giá của bạn...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () async {
            if (reviewController.text.isNotEmpty) {
              try {
                // Post the review (assuming rating is 5 for simplicity; you can add a rating input)
                await postReview(sellerId, 'Good Service', reviewController.text, 5);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đánh giá đã được gửi thành công!')),
                );
                reviewController.clear();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi khi gửi đánh giá: $e')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vui lòng nhập nội dung đánh giá')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF325A3E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: const Text('Gửi', style: TextStyle(color: Colors.white)),
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
      price: json['price']?.toString() ?? '0', // Ensure price is a string
      location: json['location'] ?? 'Không có địa điểm',
      images: (json['images'] as List?)?.map((img) => img['image_url'] as String? ?? '').toList() ?? [],
      seller: Seller.fromJson(json['User']?['UserInfo'] ?? {}), // Safely access nested fields
    );
  }
}

class Seller {
  final int id; // Add seller ID
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final double rating;

  Seller({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.rating,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'] ?? 0, // Adjust based on your API response key (e.g., 'user_id' or 'id')
      name: json['name'] ?? 'Không có tên',
      email: json['email'] ?? 'Không có email',
      phone: json['phone'] ?? 'Không có số điện thoại',
      avatarUrl: json['avatar_url'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Review {
  final int id;
  final int reviewerId;
  final int sellerId;
  final int rating;
  final String reviewTitle;
  final String reviewContent;
  final DateTime createAt;

  Review({
    required this.id,
    required this.reviewerId,
    required this.sellerId,
    required this.rating,
    required this.reviewTitle,
    required this.reviewContent,
    required this.createAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      reviewerId: json['reviewerId'] ?? 0,
      sellerId: json['sellerId'] ?? 0,
      rating: json['rating'] ?? 0,
      reviewTitle: json['reviewTitle'] ?? 'No Title',
      reviewContent: json['reviewContent'] ?? 'No Content',
      createAt: DateTime.parse(json['createAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.reviewTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF325A3E)),
                ),
                Row(
                  children: List.generate(
                    5,
                        (index) => Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.reviewContent,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            ),
            const SizedBox(height: 8),
            Text(
              'Ngày: ${DateFormat('dd/MM/yyyy').format(review.createAt)}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
