import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_bloc.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_event.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_state.dart';
import 'package:intern/presentation/home_page_screen/widgets/category_list.dart';
import 'package:intern/presentation/home_page_screen/widgets/product_grid.dart';
import 'package:intern/widgets/custom_bottom_bar.dart';
import 'package:intern/widgets/custom_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
    final PageController pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
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
            icon: Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.chat, color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => HomePageBloc()..add(LoadProductList()),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Banner quảng cáo sử dụng PageView
                    Container(
                      height: 180,
                      child: PageView(
                        controller: pageController,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgBanner,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgBanner2,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgBanner3,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          
                        ],
                      ),
                    ),
                    // SmoothPageIndicator
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                          spacing: 4.0,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                        ),
                      ),
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
                  ],
                ),
              ),
            ];
          },
          body: BlocBuilder<HomePageBloc, HomePageState>(
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
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}