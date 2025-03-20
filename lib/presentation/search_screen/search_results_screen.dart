import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_bottom_bar.dart';
import '../search_screen/bloc/search_results_bloc.dart';
import '../search_screen/bloc/search_results_event.dart';
import '../search_screen/bloc/search_results_state.dart';
class SearchResultsScreen extends StatelessWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String query = args['query'] as String;
    return SearchResultsScreen(query: query);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchResultsBloc()..add(LoadSearchResults(query)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0047AB),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Kết quả tìm kiếm: $query'),
        ),
        body: BlocBuilder<SearchResultsBloc, SearchResultsState>(
          builder: (context, state) {
            if (state is SearchResultsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchResultsLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.productList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final product = state.productList[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      leading: product.images.isNotEmpty
                          ? Image.network(
                        product.images[0],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                      )
                          : const Icon(Icons.image_not_supported),
                      title: Text(product.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Giá: ${product.price}'),
                          Text('Địa điểm: ${product.location}'),
                        ],
                      ),
                      onTap: () {
                        // Navigate to ProductDetailScreen if needed
                        Navigator.pushNamed(
                          context,
                          '/product_detail_screen',
                          arguments: {'productId': product.id},
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is SearchResultsError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
        // bottomNavigationBar: SizedBox(
        //   width: double.maxFinite,
        //   child: CustomBottomBar(
        //     onChanged: (BottomBarEnum type) {},
        //   ),
        // ),
      ),
    );
  }
}
