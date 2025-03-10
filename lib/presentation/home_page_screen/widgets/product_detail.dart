import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/homepage_model.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết sản phẩm',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0047AB),
        centerTitle: true, // Center the title
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200, // Set a fixed height for the image
              width: double.infinity, // Make the image take the full width
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover, // Ensure the image covers the entire container
              ),
            ),
            const SizedBox(height: 16),
            Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${formatCurrency(product.price)} đ', style: const TextStyle(fontSize: 20, color: Colors.red)),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }
}