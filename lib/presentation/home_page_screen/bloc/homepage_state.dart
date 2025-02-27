import 'package:intern/presentation/home_page_screen/models/homepage_model.dart';



abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<Product> productList;

  HomePageLoaded({required this.productList});
}

class HomePageError extends HomePageState {
  final String message;

  HomePageError({required this.message});
}
