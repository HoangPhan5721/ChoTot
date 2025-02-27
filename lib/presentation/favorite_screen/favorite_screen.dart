import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/presentation/favorite_screen/bloc/favorite_bloc.dart';
import 'package:intern/presentation/favorite_screen/bloc/favorite_event.dart';
import 'package:intern/presentation/favorite_screen/bloc/favorite_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB), // Màu nền của AppBar
        title: Text(
          'Yêu thích',
          style: TextStyle(
            color: Colors.white, // Đổi màu text của title thành trắng
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white), // Đổi màu icon mũi tên quay lại thành trắng
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => FavoriteBloc()..add(LoadFavoritesEvent()),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FavoriteLoaded) {
              return ListView.builder(
                itemCount: state.favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = state.favoriteItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.description),
                  );
                },
              );
            } else if (state is FavoriteError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Không có mục yêu thích nào.'));
          },
        ),
      ),
    );
  }
}
