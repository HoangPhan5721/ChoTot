import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/app_export.dart';
import '../models/cartitemlist_item_model.dart';
import '../models/my_cart_model.dart';

part 'my_cart_event.dart';
part 'my_cart_state.dart';

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  MyCartBloc(MyCartState initialState) : super(initialState) {
    on<MyCartInitialEvent>(_onInitialize);
  }

  _onInitialize(
      MyCartInitialEvent event,
      Emitter<MyCartState> emit,
      ) async {
    try {
      // Fetch data from API
      final cartItems = await fetchCartItemsFromApi();
      print('Fetched ${cartItems.length} items successfully');
      final updatedModel = state.myCartModelObj ?? MyCartModel();
      emit(
        state.copyWith(
          myCartModelObj: updatedModel.copyWith(
            cartitemslistItemList: cartItems,
          ),
        ),
      );
    } catch (e) {
      // Handle error (e.g., emit an error state)
      print('Error fetching cart items: $e');
      emit(state); // Emit current state as fallback
    }
  }

  Future<List<CartitemslistItemModel>> fetchCartItemsFromApi() async {
    try {
      print('Making GET request to https://nodejs-cgor.onrender.com/api/posts/all');
      final response = await http.get(
        Uri.parse('https://nodejs-cgor.onrender.com/api/posts/all'),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('Parsed JSON: $jsonData');

        if (jsonData['success'] == true) {
          final List<dynamic> items = jsonData['data']['data'];
          print('Number of items in response: ${items.length}');
          print('First item: ${items.isNotEmpty ? items[0] : "No items"}');

          final cartItems =
          items.map((item) => CartitemslistItemModel.fromJson(item)).toList();
          print('Mapped ${cartItems.length} items to CartitemslistItemModel');
          return cartItems;
        } else {
          throw Exception('API returned success: false - Message: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to load cart items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchCartItemsFromApi: $e');
      rethrow; // Rethrow to catch it in _onInitialize
    }
  }
}
