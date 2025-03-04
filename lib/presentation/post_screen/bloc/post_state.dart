part of 'post_bloc.dart';

/// Represents the state of Post in the application.
// ignore_for_file: must_be_immutable
class PostState extends Equatable {
  PostState(
      {this.inputfieldoneController,
      this.categoryInputSectionController,
      this.inputfieldfiveController,
      this.pricetwoController,
      this.locationtwoController,
      this.PostModelObj});

  TextEditingController? inputfieldoneController;
  TextEditingController? categoryInputSectionController;
  TextEditingController? inputfieldfiveController;
  TextEditingController? pricetwoController;
  TextEditingController? locationtwoController;
  PostModel? PostModelObj;

  @override
  List<Object?> get props => [
        inputfieldoneController,
        categoryInputSectionController,
        inputfieldfiveController,
        pricetwoController,
        locationtwoController,
        PostModelObj
      ];

  PostState copyWith({
    TextEditingController? inputfieldoneController,
    TextEditingController? categoryInputSectionController,
    TextEditingController? inputfieldfiveController,
    TextEditingController? pricetwoController,
    TextEditingController? locationtwoController,
    PostModel? PostModelObj,
  }) {
    return PostState(
      inputfieldoneController:
          inputfieldoneController ?? this.inputfieldoneController,
      categoryInputSectionController:
          categoryInputSectionController ?? this.categoryInputSectionController,
      inputfieldfiveController:
          inputfieldfiveController ?? this.inputfieldfiveController,
      pricetwoController: pricetwoController ?? this.pricetwoController,
      locationtwoController:
          locationtwoController ?? this.locationtwoController,
      PostModelObj:
          PostModelObj ?? this.PostModelObj,
    );
  }
}
