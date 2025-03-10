// import 'package:flutter/material.dart';
// import 'product_detail.dart';
// import '../models/homepage_model.dart';

// class SubCategoryDetailScreen extends StatelessWidget {
//   final String subCategoryName;

//   const SubCategoryDetailScreen({super.key, required this.subCategoryName});

//   @override
//   Widget build(BuildContext context) {
//     final List<Product> relatedProducts = getRelatedProducts(subCategoryName);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           subCategoryName,
//           style: TextStyle(fontSize: 18, color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF0047AB),
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: ListView.builder(
//         itemCount: relatedProducts.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(relatedProducts[index].name),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetail(product: relatedProducts[index]),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   List<Product> getRelatedProducts(String subCategory) {
//     // Thay thế bằng logic thực tế để lấy dữ liệu từ API hoặc database
//     return List.generate(10, (index) => Product(
//       name: '$subCategory Product $index',
//       price: 1000000.0 + index * 100000,
//       description: 'Description for $subCategory Product $index',
//       imageUrl: 'https://via.placeholder.com/150',
//     ));
//   }
// }