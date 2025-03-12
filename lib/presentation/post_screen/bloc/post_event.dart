part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class PostInitialEvent extends PostEvent {}

class TitleChangedEvent extends PostEvent {
  final String title;
  const TitleChangedEvent(this.title);
  @override
  List<Object?> get props => [title];
}

class CategorySelectedEvent extends PostEvent {
  final int categoryId;
  final String categoryName;
  const CategorySelectedEvent(this.categoryId, this.categoryName);
  @override
  List<Object?> get props => [categoryId, categoryName];
}

class ProductNameChangedEvent extends PostEvent {
  final String productName;
  const ProductNameChangedEvent(this.productName);
  @override
  List<Object?> get props => [productName];
}

class DescriptionChangedEvent extends PostEvent {
  final String description;
  const DescriptionChangedEvent(this.description);
  @override
  List<Object?> get props => [description];
}

class PriceChangedEvent extends PostEvent {
  final String price;
  const PriceChangedEvent(this.price);
  @override
  List<Object?> get props => [price];
}

// Add this new event
class ImageSelectedEvent extends PostEvent {
  final File imageFile;
  const ImageSelectedEvent(this.imageFile);
  @override
  List<Object?> get props => [imageFile];
}
class LocationChangedEvent extends PostEvent {
  final String location;
  const LocationChangedEvent(this.location);
  @override
  List<Object?> get props => [location];
}

class ProductStatusChangedEvent extends PostEvent {
  final String status;
  const ProductStatusChangedEvent(this.status);
  @override
  List<Object?> get props => [status];
}
