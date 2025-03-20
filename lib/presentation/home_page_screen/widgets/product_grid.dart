import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../productcard_screen/product_card.dart'; // Assuming this is ProductDetailScreen
import '../models/homepage_model.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> productList;
  final String? token; // Token is already included

  const ProductGrid({super.key, required this.productList, this.token});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: productList[index],
          token: token, // Pass the token to ProductCard
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final String? token; // Add token parameter

  const ProductCard({super.key, required this.product, this.token});

  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to ProductDetailScreen with productId and token
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productId: product.id,
              token: token, // Pass the token here
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.imageUrl.isNotEmpty
                ? Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported,
                    size: 50, color: Colors.grey);
              },
            )
                : const Icon(Icons.image_not_supported,
                size: 50, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${formatCurrency(product.price)} đ',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
