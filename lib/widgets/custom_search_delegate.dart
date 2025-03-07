import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_bloc.dart';
import 'package:intern/presentation/home_page_screen/bloc/homepage_state.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Các nút hành động trong thanh tìm kiếm (chẳng hạn như nút xóa)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Xóa kết quả tìm kiếm khi nhấn nút này
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Nút quay lại (đóng thanh tìm kiếm)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Đóng thanh tìm kiếm
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Xử lý kết quả tìm kiếm
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageLoaded) {
          final filteredList = state.productList
              .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final product = filteredList[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('${product.price} VND'),
                leading: Image.network(product.imageUrl),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Đưa ra các gợi ý khi người dùng bắt đầu nhập vào thanh tìm kiếm
    return Center(
      child: Text('Tìm kiếm sản phẩm...'),
    );
  }
}
