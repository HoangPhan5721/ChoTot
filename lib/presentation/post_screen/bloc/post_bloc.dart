import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_export.dart';
import '../models/post_model.dart';
import 'dart:io'; // Add this import

part 'post_event.dart';
part 'post_state.dart';

/// A bloc that manages the state of a Post according to the event that is dispatched to it.
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState()) {
    on<PostInitialEvent>(_onInitialize);
    on<TitleChangedEvent>(_onTitleChanged);
    on<CategorySelectedEvent>(_onCategorySelected);
    on<ProductNameChangedEvent>(_onProductNameChanged);
    on<DescriptionChangedEvent>(_onDescriptionChanged);
    on<PriceChangedEvent>(_onPriceChanged);
    on<LocationChangedEvent>(_onLocationChanged);
    on<ProductStatusChangedEvent>(_onProductStatusChanged);
    on<ImageSelectedEvent>(_onImageSelected);
  }

  void _onInitialize(PostInitialEvent event, Emitter<PostState> emit) {
    emit(PostState(
      titleController: TextEditingController(),
      categoryController: TextEditingController(),
      productNameController: TextEditingController(),
      descriptionController: TextEditingController(),
      priceController: TextEditingController(),
      locationController: TextEditingController(),
      postModelObj: PostModel(),
      selectedStatus: 'new',
      imageFile: null,
    ));
  }
  void _onProductStatusChanged(
      ProductStatusChangedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      selectedStatus: event.status,
      postModelObj: state.postModelObj?.copyWith(status: event.status),
    ));
  }
  void _onImageSelected(
      ImageSelectedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      imageFile: event.imageFile,
      postModelObj: state.postModelObj?.copyWith(
        imagePath: event.imageFile.path, // Optional: if your PostModel has an imagePath field
      ),
    ));
  }
  void _onTitleChanged(
      TitleChangedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      postModelObj: state.postModelObj?.copyWith(title: event.title),
    ));
  }

  void _onCategorySelected(
      CategorySelectedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      selectedCategoryId: event.categoryId,
      categoryController: TextEditingController(text: event.categoryName),
      postModelObj: state.postModelObj?.copyWith(categoryId: event.categoryId),
    ));
  }

  void _onProductNameChanged(
      ProductNameChangedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      postModelObj: state.postModelObj?.copyWith(productName: event.productName),
    ));
  }

  void _onDescriptionChanged(
      DescriptionChangedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      postModelObj: state.postModelObj?.copyWith(description: event.description),
    ));
  }

  void _onPriceChanged(
      PriceChangedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      postModelObj: state.postModelObj?.copyWith(price: event.price),
    ));
  }

  void _onLocationChanged(
      LocationChangedEvent event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(
      postModelObj: state.postModelObj?.copyWith(location: event.location),
    ));
  }
}
