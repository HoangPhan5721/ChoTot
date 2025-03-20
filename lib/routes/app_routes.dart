import 'package:flutter/material.dart';
// import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/home_page_screen/homepage_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/my_cart_screen/my_cart_screen.dart';
// import '../presentation/order_screen/order_screen.dart';
// import '../presentation/payment_screen/payment_screen.dart';
import '../presentation/register_screen/register_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/personal_screen/personal_screen.dart';
import '../presentation/post_screen/post_screen.dart';
import '../presentation/inf_personal_screen/inf_personal_screen.dart';
import '../presentation/search_screen/search_results_screen.dart';
import '../presentation/chat_screen/chat_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String homeScreen = '/homepage_screen';
  static const String homeInitialPage = '/home_initial_page';
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String personalScreen = '/personal_screen';
  static const String orderScreen = '/order_screen';
  static const String myCartScreen = '/my_cart_screen';
  static const String paymentScreen = '/payment_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';
  static const String postScreen = '/post_screen';
  static const String infPersonalScreen = '/inf_personal_screen';
  static const String searchScreen = '/search_results_screen';
  static const String chatScreen = '/chat_screen';

  static Map<String, WidgetBuilder> get routes => {
    splashScreen: SplashScreen.builder,
    searchScreen: SearchResultsScreen.builder,
    infPersonalScreen: InfPersonalScreen.builder,
    homeScreen: HomePageScreen.builder,
    loginScreen: LoginScreen.builder,
    registerScreen: RegisterScreen.builder,
    // orderScreen: OrderScreen.builder,
    postScreen: PostScreen.builder,
    personalScreen: PersonalPage.builder,
    myCartScreen: MyCartScreen.builder,
    // paymentScreen: PaymentScreen.builder,
    // appNavigationScreen: AppNavigationScreen.builder,
    initialRoute: LoginScreen.builder,
    // initialRoute: HomePageScreen.builder,
    chatScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args == null) {
        return const Center(child: Text("Error: No arguments provided"));
      }
      return ChatScreen(
        token: args['token'] as String, // Ensure token is passed when navigating
        sellerId: args['sellerId'].toString(),
        sellerName: args['sellerName'] as String,
        profileImage: args['profileImage'] as String?,
      );
    },
  };
}
