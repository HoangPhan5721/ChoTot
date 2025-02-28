import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:intern/product_card.dart'; // Update with the correct import

void main() {
  testWidgets('ProductCard displays correctly', (WidgetTester tester) async {
    // Arrange: Build the widget inside a test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(
            name: 'Test Plant',
            price: 29.99,
            imagePath: 'https://via.placeholder.com/150',
            height: 12.5,
            humidity: 80,
            temperature: 22.5,
            rating: 4.5,
            onBuyNow: () {}, // Provide empty callbacks for button actions
            onAddToCart: () {},
          ),
        ),
      ),
    );

    // Act: Wait for the widget to settle
    await tester.pump();

    // Assert: Check if the widget is displayed with expected text
    expect(find.text('Test Plant'), findsOneWidget);
    expect(find.text('\$29.99'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.byType(ProductCard), findsOneWidget);
  });
}
