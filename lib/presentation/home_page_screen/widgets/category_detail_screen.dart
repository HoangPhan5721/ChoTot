import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/homepage_bloc.dart';
import '../bloc/homepage_event.dart'; // Import LoadProductList event
import '../bloc/homepage_state.dart';
import '../models/homepage_model.dart';
import 'product_grid.dart'; // Import ProductGrid

class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;

  const CategoryDetailScreen({super.key, required this.categoryName});

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  String? selectedSubCategory;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subCategories = getSubCategories(widget.categoryName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0047AB),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocProvider(
        create: (context) => HomePageBloc()..add(LoadProductList()), // Ensure HomePageBloc is provided and LoadProductList event is added
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Khám phá danh mục',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100, // Điều chỉnh chiều cao của danh mục
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategories.length,
                  itemBuilder: (context, index) {
                    final isSelected = subCategories[index]['name'] == selectedSubCategory;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSubCategory = subCategories[index]['name'] == 'Tất cả' ? null : subCategories[index]['name'];
                        });
                      },
                      child: Container(
                        width: 100, // Điều chỉnh chiều rộng của mỗi mục
                        padding: EdgeInsets.symmetric(horizontal: 10.0), // Khoảng cách giữa các mục
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: isSelected ? Border.all(color: Color(0xFF0047AB), width: 2) : null,
                              ),
                              child: Icon(subCategories[index]['icon'], size: 40, color: Color(0xFF0047AB)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              subCategories[index]['name'],
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Gợi ý hôm nay',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state is HomePageLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomePageLoaded) {
                    final products = state.productList.where((product) => product.category == widget.categoryName && (selectedSubCategory == null || product.type == selectedSubCategory)).toList();
                    return ProductGrid(productList: products); // Sử dụng ProductGrid
                  } else if (state is HomePageError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> getSubCategories(String category) {
    switch (category) {
      case 'Xe cộ':
        return [
          {'name': 'Tất cả', 'icon': FontAwesomeIcons.borderAll},
          {'name': 'Xe máy', 'icon': Icons.motorcycle},
          {'name': 'Ô tô', 'icon': Icons.directions_car},
          {'name': 'Xe đạp', 'icon': Icons.directions_bike},
          {'name': 'Xe điện', 'icon': Icons.electric_bike},
        ];
      case 'Đồ điện tử':
        return [
          {'name': 'Tất cả', 'icon': FontAwesomeIcons.borderAll},
          {'name': 'Điện thoại', 'icon': Icons.phone_android},
          {'name': 'Laptop', 'icon': Icons.laptop},
          {'name': 'PC', 'icon': Icons.desktop_windows},
          {'name': 'Tivi', 'icon': Icons.tv},
        ];
      case 'Đồ gia dụng, nội thất':
        return [
          {'name': 'Tất cả', 'icon': FontAwesomeIcons.borderAll},
          {'name': 'Bàn ghế', 'icon': Icons.chair},
          {'name': 'Giường ngủ', 'icon': Icons.king_bed},
          {'name': 'Máy giặt', 'icon': Icons.wash},
          {'name': 'Quạt', 'icon': Icons.ac_unit},
        ];
      case 'Thú cưng':
        return [
          {'name': 'Tất cả', 'icon': FontAwesomeIcons.borderAll},
          {'name': 'Chó', 'icon': FontAwesomeIcons.dog},
          {'name': 'Mèo', 'icon': FontAwesomeIcons.cat},
        ];
      default:
        return [];
    }
  }
}