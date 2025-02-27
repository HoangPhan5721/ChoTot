// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'favorite_event.dart';
// part 'favorite_state.dart';

// class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
//   FavoriteBloc() : super(FavoriteInitial()) {
//     on<FavoriteEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteItem {
  final String name;
  final String description;

  FavoriteItem(this.name, this.description);
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoading()) {
    // Sử dụng on<LoadFavoritesEvent> thay vì mapEventToState
    on<LoadFavoritesEvent>((event, emit) async {
      try {
        // Giả lập việc tải dữ liệu yêu thích (có thể lấy từ API hoặc local database)
        await Future.delayed(Duration(seconds: 2)); // Giả lập độ trễ
        List<FavoriteItem> favoriteItems = [
          FavoriteItem('Item 1', 'Description 1'),
          FavoriteItem('Item 2', 'Description 2'),
          FavoriteItem('Item 3', 'Description 3'),
        ];
        emit(FavoriteLoaded(favoriteItems)); // Phát trạng thái FavoriteLoaded
      } catch (e) {
        emit(FavoriteError('Không thể tải dữ liệu yêu thích')); // Phát trạng thái lỗi
      }
    });
  }
}
