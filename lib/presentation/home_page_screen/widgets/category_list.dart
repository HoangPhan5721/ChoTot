import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Điều chỉnh chiều cao của danh mục
      child: ListView(
        scrollDirection: Axis.horizontal, // Lướt ngang
        children: [
          CategoryItem(name: 'Bất động sản', icon: Icons.home),
          CategoryItem(name: 'Xe cộ', icon: Icons.car_repair),
          CategoryItem(name: 'Đồ điện tử', icon: Icons.devices),
          CategoryItem(name: 'Thú cưng', icon: Icons.pets),
          CategoryItem(name: 'Việc làm', icon: Icons.work),
          CategoryItem(name: 'Đồ gia dụng', icon: Icons.kitchen),
          CategoryItem(name: 'Đồ ăn', icon: Icons.fastfood),
          CategoryItem(name: 'Thời trang', icon: Icons.shopping_bag),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const CategoryItem({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Điều chỉnh chiều rộng của mỗi mục
      padding: EdgeInsets.symmetric(horizontal: 8.0), // Khoảng cách giữa các mục
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều ngang
        children: [
          // Đảm bảo icon luôn ở trên cùng và căn giữa
          Icon(icon, size: 40, color: Color(0xFF0047AB)),
          SizedBox(height: 8), // Khoảng cách giữa icon và text
          // Text sẽ tự động xuống dòng nhưng sẽ căn chỉnh đều với icon
          Text(
            name,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
            maxLines: 2, // Tối đa 2 dòng cho text
            overflow: TextOverflow.ellipsis, // Cắt bớt text nếu dài
          ),
        ],
      ),
    );
  }
}
