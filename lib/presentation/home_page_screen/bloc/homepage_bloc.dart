import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'homepage_event.dart';
import 'homepage_state.dart';
import 'package:intern/presentation/home_page_screen/models/homepage_model.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  List<Product> allProducts = []; // Store all products

  HomePageBloc() : super(HomePageInitial()) {
    on<LoadProductList>(_onLoadProductList);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProductList(
      LoadProductList event, Emitter<HomePageState> emit) async {
    emit(HomePageLoading());
    try {
      List<Product> productList = await fetchProductList();
      allProducts = productList; // ✅ Now storing fetched products
      emit(HomePageLoaded(productList: allProducts)); // ✅ Show fetched products
    } catch (e) {
      emit(HomePageError(message: 'Lỗi khi tải sản phẩm: ${e.toString()}'));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<HomePageState> emit) {
    if (event.query.isEmpty) {
      // ✅ If search is empty, show all products
      emit(HomePageLoaded(productList: allProducts));
    } else {
      final filteredProducts = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(HomePageSearchResults(filteredProducts));
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
                  id: item['id'],
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
