import 'package:flutter/material.dart';
import 'package:intern/product_card.dart'; // Update import

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("Product Card Preview")),
      body: Center(
        child: ProductCard(
          name: 'Test Plant',
          price: 29.99,
          imagePath: 'https://placehold.co/300x200',
          height: 12.5,
          humidity: 80,
          temperature: 22.5,
          rating: 4.5,
          onBuyNow: () {
            print("Buy Now Clicked!");
          },
          onAddToCart: () {
            print("Added to Cart!");
          },
        ),
      ),
    ),
  ));
}
