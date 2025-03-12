part of 'register_bloc.dart';

/// Represents the state of Register in the application.
// ignore_for_file: must_be_immutable
class RegisterState extends Equatable {
  RegisterState({
    this.fullNameInputController,
    this.emailInputController,
    this.passwordInputController,
    this.confirmPasswordInputController,
    this.registerModelObj,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  TextEditingController? fullNameInputController;
  TextEditingController? emailInputController;
  TextEditingController? passwordInputController;
  TextEditingController? confirmPasswordInputController;
  RegisterModel? registerModelObj;
  final bool isLoading; // Thêm thuộc tính này
  final bool isSuccess; // Thêm thuộc tính này
  final String? errorMessage; // Thêm thuộc tính này
  @override
  List<Object?> get props => [
    fullNameInputController,
    emailInputController,
    passwordInputController,
    confirmPasswordInputController,
    registerModelObj,
    isLoading, // Thêm vào props để Equatable nhận diện thay đổi
    isSuccess,
    errorMessage,
  ];

  RegisterState copyWith({
    TextEditingController? fullNameInputController,
    TextEditingController? emailInputController,
    TextEditingController? passwordInputController,
    TextEditingController? confirmPasswordInputController,
    RegisterModel? registerModelObj,
    bool? isLoading, // Thêm vào copyWith
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      fullNameInputController:
      fullNameInputController ?? this.fullNameInputController,
      emailInputController: emailInputController ?? this.emailInputController,
      passwordInputController:
      passwordInputController ?? this.passwordInputController,
      confirmPasswordInputController:
      confirmPasswordInputController ?? this.confirmPasswordInputController,
      registerModelObj: registerModelObj ?? this.registerModelObj,
      isLoading: isLoading ?? this.isLoading, // Cập nhật giá trị isLoading
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
