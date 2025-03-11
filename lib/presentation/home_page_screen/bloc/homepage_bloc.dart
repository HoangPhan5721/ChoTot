import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'homepage_event.dart';
import 'homepage_state.dart';
import 'package:intern/presentation/home_page_screen/models/homepage_model.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<LoadProductList>(_onLoadProductList);
  }

  Future<void> _onLoadProductList(
      LoadProductList event, Emitter<HomePageState> emit) async {
    emit(HomePageLoading());
    try {
      List<Product> productList = await fetchProductList();
      emit(HomePageLoaded(productList: productList));
    } catch (e) {
      emit(HomePageError(message: 'Lỗi khi tải sản phẩm: ${e.toString()}'));
    }
  }

  Future<List<Product>> fetchProductList() async {
    final response = await http.get(
        Uri.parse('https://nodejs-cgor.onrender.com/api/posts/all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        List<Product> products = (data['data']['data'] as List)
            .map((item) => Product(
                  name: item['title'],
                  price: double.parse(item['price']),
                  imageUrl: item['images'].isNotEmpty
                      ? item['images'][0]['image_url']
                      : '',
                ))
            .toList();
        return products;
      } else {
        throw Exception('Lỗi từ API: ${data['message']}');
      }
    } else {
      throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
    }
  }
}
