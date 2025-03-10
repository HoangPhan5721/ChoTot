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
      Product(category: 'Đồ gia dụng, nội thất', name: 'Sofa', price: 10000000, imageUrl: 'https://kika.vn/wp-content/uploads/2022/11/sofa-sf217-anh-thuc-te.jpg', description: 'Sofa màu xám, chất liệu vải cao cấp', type: 'Bàn ghế'),
      Product(category: 'Đồ gia dụng, nội thất', name: 'Bàn ăn', price: 4000000, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-FJ0G040jLplwh8CZYhmCuDhQd_MMh1a_FA&s', description: 'Bàn ăn gỗ sồi tự nhiên', type: 'Bàn ghế'),
      Product(category: 'Đồ điện tử', name: 'Iphone 16 Pro Max', price: 29000000, imageUrl: 'https://cdn.viettelstore.vn/Images/Product/ProductImage/1503657514.jpeg', description: 'Còn mới 99%, bảo hành 12 tháng', type: 'Điện thoại'),
      Product(category: 'Đồ điện tử', name: 'Macbook Pro 2022', price: 40000000, imageUrl: 'https://bizweb.dktcdn.net/thumb/1024x1024/100/116/615/products/mbp-spacegray-select-202206-jpeg.jpg', description: 'Macbook Pro 2022, chip M2, 16GB RAM, 512GB SSD', type: 'Laptop'),
      Product(category: 'Xe cộ', name: 'Exciter 155', price: 38000000, imageUrl: 'https://xetuandat.com/wp-content/uploads/2024/06/mua-ban-ex-155-2023-xe-dep-may-zin-1-scaled.jpeg', description: 'Xe côn tay Yamaha Exciter 155 màu trắng, full giấy tờ', type: 'Xe máy'),
      Product(category: 'Xe cộ', name: 'Mer C300', price: 2090000000, imageUrl: 'https://vuongkhangmotor.com/upload/product/101010-8333.jpg', description: 'Mercedes C300 màu trắng, giấy tờ đầy đủ, chưa trầy xước gì, chạy 10000km', type: 'Ô tô'),
      Product(category: 'Đồ gia dụng, nội thất', name: 'Giường ngủ gỗ cao cấp', price: 3500000, imageUrl: 'https://noithattienloc.com/wp-content/uploads/2023/09/giuong-mdf.jpg', description: 'Giường ngủ gỗ sồi tự nhiên, chất lượng cao', type: 'Giường ngủ'),
      Product(category: 'Đồ gia dụng, nội thất', name: 'Máy giặt LG', price: 8000000, imageUrl: 'https://dienmaybanre.com/images/products/2021/10/31/large/may-giat-lg-fv14s3b-1_1635672084.jpg', description: 'Máy giặt LG 10kg, mới 100%, bảo hành 24 tháng', type: 'Máy giặt'),
      Product(category: 'Thú cưng', name: 'Chó Poodle', price: 5000000, imageUrl: 'https://azpet.com.vn/wp-content/uploads/2021/08/Poodle-Toy-Nau-Do-C12366-1.jpg', description: 'Chó Poodle màu nâu, 3 tháng tuổi, đã tiêm phòng đầy đủ', type: 'Chó'),
      // Thêm các sản phẩm khác nếu cần
    ];
  }
  // Phương thức để lọc sản phẩm theo category
  List<Product> filterProductsByCategory(List<Product> products, String category) {
    return products.where((product) => product.category == category).toList();
  }
}
