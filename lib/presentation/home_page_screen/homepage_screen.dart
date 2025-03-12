import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_bloc.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_event.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_state.dart';
import 'package:intern/presentation/home_page_screen/widgets/category_list.dart';
import 'package:intern/presentation/home_page_screen/widgets/product_grid.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../notification_screen/notification_screen.dart';
//import 'package:intern/widgets/custom_search_delegate.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  // Thêm phương thức builder để sử dụng trong AppRoutes
  static Widget builder(BuildContext context) {
    return HomePageScreen(); // Trả về widget HomePageScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4CAF50),
          title: Container(
            width: 300,
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
              ),
              onChanged: (value) {
                // Xử lý khi người dùng nhập vào ô tìm kiếm
                // Bạn có thể thêm logic để tìm kiếm sản phẩm tại đây
              },
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => HomePageBloc()..add(LoadProductList()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Banner quảng cáo sử dụng CustomImageView
                CustomImageView(
                  imagePath: ImageConstant
                      .imgBanner, // Sử dụng imgBanner từ ImageConstants
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Khám phá danh mục
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Khám phá danh mục',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                CategoryList(),
                // Tin đăng mới
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tin đăng mới',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                BlocBuilder<HomePageBloc, HomePageState>(
                  builder: (context, state) {
                    if (state is HomePageLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomePageLoaded) {
                      return ProductGrid(productList: state.productList);
                    } else if (state is HomePageError) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
        SizedBox(
          width: double.maxFinite,
          child: _buildBottomBar(context),
        )
    );
  }
  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {},
      ),
    );
  }
}
