

abstract class HomePageEvent {}

class LoadProductList extends HomePageEvent {} // Sự kiện tải danh sách sản phẩm

class SearchProducts extends HomePageEvent {
  final String query;

  SearchProducts(this.query);
}
