import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../search_screen/models/product.dart';// Import the Product model
import 'search_results_event.dart';
import 'search_results_state.dart';

class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState> {
  SearchResultsBloc() : super(SearchResultsLoading()) {
    on<LoadSearchResults>(_onLoadSearchResults);
  }

  Future<void> _onLoadSearchResults(
      LoadSearchResults event,
      Emitter<SearchResultsState> emit,
      ) async {
    emit(SearchResultsLoading());
    try {
      final response = await http.get(
        Uri.parse('https://nodejs-cgor.onrender.com/api/posts/all/?product_name=${event.query}'),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == true) {
          final List<dynamic> data = jsonData['data']['data'];
          final productList = data.map((json) => Product.fromJson(json)).toList();
          emit(SearchResultsLoaded(productList));
        } else {
          emit(SearchResultsError('Failed to load products: ${jsonData['message']}'));
        }
      } else {
        emit(SearchResultsError('Error: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SearchResultsError('Error: $e'));
    }
  }
}
