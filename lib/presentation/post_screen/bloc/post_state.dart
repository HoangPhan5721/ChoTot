part of 'post_bloc.dart';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import '../models/post_model.dart';

class PostState extends Equatable {
  final TextEditingController? titleController;
  final TextEditingController? categoryController;
  final TextEditingController? productNameController;
  final TextEditingController? descriptionController;
  final TextEditingController? priceController;
  final TextEditingController? locationController;
  final PostModel? postModelObj;
  final String? selectedStatus;
  final int? selectedCategoryId;
  final File? imageFile;

  const PostState({
    this.titleController,
    this.categoryController,
    this.productNameController,
    this.descriptionController,
    this.priceController,
    this.locationController,
    this.postModelObj,
    this.selectedStatus,
    this.selectedCategoryId,
    this.imageFile,
  });

  PostState copyWith({
    TextEditingController? titleController,
    TextEditingController? categoryController,
    TextEditingController? productNameController,
    TextEditingController? descriptionController,
    TextEditingController? priceController,
    TextEditingController? locationController,
    PostModel? postModelObj,
    String? selectedStatus,
    int? selectedCategoryId,
    File? imageFile,
  }) {
    return PostState(
      titleController: titleController ?? this.titleController,
      categoryController: categoryController ?? this.categoryController,
      productNameController: productNameController ?? this.productNameController,
      descriptionController: descriptionController ?? this.descriptionController,
      priceController: priceController ?? this.priceController,
      locationController: locationController ?? this.locationController,
      postModelObj: postModelObj ?? this.postModelObj,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  @override
  List<Object?> get props => [
    titleController,
    categoryController,
    productNameController,
    descriptionController,
    priceController,
    locationController,
    postModelObj,
    selectedStatus,
    selectedCategoryId,
    imageFile,
  ];
}
