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

class HomePageScreen extends StatelessWidget {
  final int? userId;
  final String? token; // Add token field

  const HomePageScreen({super.key, this.userId, this.token});

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int? userId = args?['userId'] as int?;
    final String? token = args?['token'] as String?; // Extract token from arguments
    return HomePageScreen(userId: userId, token: token);
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0047AB),
        title: Container(
          width: 300,
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  '/search_results_screen',
                  arguments: {'query': value},
                );
              }
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () {
              if (token == null || userId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please log in to access chat')),
                );
                return;
              }
              // Navigate to ChatScreen with token and placeholder seller info
              Navigator.pushNamed(
                context,
                '/chat_screen',
                arguments: {
                  'token': token,
                  'sellerId': '1', // Replace with actual sellerId if available
                  'sellerName': 'Hoang Phan', // Replace with actual seller name
                  'profileImage': '', // Replace with actual profile image if available
                },
              );
            },
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: const WormEffect(
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                          spacing: 4.0,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Khám phá danh mục',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    CategoryList(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
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
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomePageLoaded) {
                return ProductGrid(
                  productList: state.productList,
                  token: token, // Token is passed here
                );
              } else if (state is HomePageError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Navigating to PostScreen with userId: $userId");
          Navigator.pushNamed(
            context,
            '/post_screen',
            arguments: {'userId': userId},
          );
        },
        backgroundColor: const Color(0xFF0047AB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        userId: userId,
        onChanged: (BottomBarEnum type) {
          print("BottomBar selected: $type with userId: $userId");
        },
      ),
    );
  }
}
