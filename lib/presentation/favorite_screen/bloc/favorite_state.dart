// part of 'favorite_bloc.dart';

// sealed class FavoriteState extends Equatable {
//   const FavoriteState();
  
//   @override
//   List<Object> get props => [];
// }

// final class FavoriteInitial extends FavoriteState {}
import 'package:intern/presentation/favorite_screen/bloc/favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteItem> favoriteItems;

  FavoriteLoaded(this.favoriteItems);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}
