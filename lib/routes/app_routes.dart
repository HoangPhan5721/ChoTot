import 'package:flutter/material.dart';
import 'package:intern/presentation/post_screen/post_screen.dart';
// import '../presentation/app_navigation_screen/app_navigation_screen.dar
// import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/my_cart_screen/my_cart_screen.dart';
// import '../presentation/order_screen/order_screen.dart';
// import '../presentation/payment_screen/payment_screen.dart';
import '../presentation/register_screen/register_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/personal_screen/personal_screen.dart';
import '../presentation/productcard_screen/product_card.dart';
import '../presentation/chat_screen/chat_screen.dart';
class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String homeScreen = '/home_screen';
  static const String homeInitialPage = '/home_initial_page';
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String orderScreen = '/order_screen';
  static const String myCartScreen = '/my_cart_screen';
  static const String paymentScreen = '/payment_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';
  static const String postScreen = '/post_screen';
  static const String personalScreen = '/personal_screen';
  static const String productCardScreen = '/product_card_screen';
  static const String chatScreen = '/chat_screen';


  ////
  static void _onBuyNow() {
    print("Buy Now Clicked!");
  }

  static void _onAddToCart() {
    print("Add to Cart Clicked!");
  }
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case chatScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) =>
              ChatScreen(
                sellerId: args?['sellerId'] ?? '',
                sellerName: args?['sellerName'] ?? 'Unknown',
                profileImage: args?['profileImage'] ?? '',
              ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
  static Map<String, WidgetBuilder> get routes => {
    splashScreen: SplashScreen.builder,
    // homeScreen: HomeScreen.builder,
    postScreen : PostScreen.builder,
    loginScreen: LoginScreen.builder,
    registerScreen: RegisterScreen.builder,
    // orderScreen: OrderScreen.builder,
    myCartScreen: MyCartScreen.builder,
    personalScreen: PersonalPage.builder,
    // paymentScreen: PaymentScreen.builder,
    // appNavigationScreen: AppNavigationScreen.builder,
    initialRoute: SplashScreen.builder,


    ////
    chatScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      return ChatScreen(
        sellerId: args?['sellerId'] ?? '',
        sellerName: args?['sellerName'] ?? 'Unknown',
        profileImage: args?['profileImage'] ?? '',
      );
    },
    productCardScreen: (context) => const ProductCard(
      name: "Kamen Rider Belt",
      price: 99.99,
      imagePath: "assets/images/product.jfif",
      height: 12.5,
      humidity: 50.0,
      temperature: 25.0,
      rating: 4.5,
      onBuyNow: _onBuyNow, // Define a function for buy now
      onAddToCart: _onAddToCart, // Define a function for add to cart
    ),

  };
}