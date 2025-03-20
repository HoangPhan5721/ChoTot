import '../../search_screen/models/product.dart';
abstract class SearchResultsState {}

class SearchResultsLoading extends SearchResultsState {}

class SearchResultsLoaded extends SearchResultsState {
  final List<Product> productList;

  SearchResultsLoaded(this.productList);
}

class SearchResultsError extends SearchResultsState {
  final String message;

  SearchResultsError(this.message);
}
