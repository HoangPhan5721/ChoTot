
part of 'register_bloc.dart';

/// Represents the state of Register in the application.
// ignore_for_file: must_be_immutable
class RegisterState extends Equatable {
  RegisterState(
      {
        this.fullNameInputController,
        this.emailInputController,
        this.passwordInputController,
        this.confirmPasswordInputController,
        this.registerModelObj});

  TextEditingController? fullNameInputController;
  TextEditingController? emailInputController;
  TextEditingController? passwordInputController;
  TextEditingController? confirmPasswordInputController;
  RegisterModel? registerModelObj;

  @override
  List<Object?> get props =>
      [
        fullNameInputController,
        emailInputController,
        passwordInputController,
        confirmPasswordInputController,
        registerModelObj
      ];

  RegisterState copyWith({
    TextEditingController? fullNameInputController,
    TextEditingController? emailInputController,
    TextEditingController? passwordInputController,
    TextEditingController? confirmPasswordInputController,
    RegisterModel? registerModelObj,
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
    );
  }
}