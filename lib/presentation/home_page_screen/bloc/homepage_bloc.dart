import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage_event.dart';
import 'homepage_state.dart';
import 'package:intern/presentation/home_page_screen/models/homepage_model.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    // Đăng ký sự kiện với `on<LoadProductList>`
    on<LoadProductList>(_onLoadProductList);
  }

  // Phương thức xử lý sự kiện `LoadProductList`
  Future<void> _onLoadProductList(
      LoadProductList event, Emitter<HomePageState> emit) async {
    emit(HomePageLoading());  // Trạng thái khi dữ liệu đang được tải
    try {
      // Giả lập việc lấy danh sách sản phẩm
      List<Product> productList = await fetchProductList();
      emit(HomePageLoaded(productList: productList)); // Trả về sản phẩm sau khi tải thành công
    } catch (e) {
      emit(HomePageError(message: 'Lỗi khi tải sản phẩm')); // Trạng thái lỗi khi có sự cố
    }
  }

  // Giả lập hàm tải danh sách sản phẩm (thay thế bằng API thật)
  Future<List<Product>> fetchProductList() async {
    return [
      Product(name: 'Sofa', price: 10000000, imageUrl: 'https://kika.vn/wp-content/uploads/2022/11/sofa-sf217-anh-thuc-te.jpg'),
      Product(name: 'Bàn ăn', price: 4000000, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-FJ0G040jLplwh8CZYhmCuDhQd_MMh1a_FA&s'),
      // Thêm các sản phẩm khác nếu cần
    ];
  }
}
