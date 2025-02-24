import 'package:flutter/material.dart';
// import '../presentation/app_navigation_screen/app_navigation_screen.dar
// import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/login_screen.dart';
// import '../presentation/my_cart_screen/my_cart_screen.dart';
// import '../presentation/order_screen/order_screen.dart';
// import '../presentation/payment_screen/payment_screen.dart';
import '../presentation/register_screen/register_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
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
  static Map<String, WidgetBuilder> get routes => {
    splashScreen: SplashScreen.builder,
    // homeScreen: HomeScreen.builder,
    loginScreen: LoginScreen.builder,
    registerScreen: RegisterScreen.builder,
    // orderScreen: OrderScreen.builder,
    // myCartScreen: MyCartScreen.builder,
    // paymentScreen: PaymentScreen.builder,
    // appNavigationScreen: AppNavigationScreen.builder,
    initialRoute: SplashScreen.builder
  };
}