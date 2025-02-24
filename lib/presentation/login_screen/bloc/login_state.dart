part of 'login_bloc.dart';

/// Represents the state of Login in the application.
// ignore_for_file: must_be_immutable
class LoginState extends Equatable {
  LoginState(
      {this.fullNameController,
      this.passwordController,
      this.remembermeone = false,
      this.loginModelObj});

  TextEditingController? fullNameController;
  TextEditingController? passwordController;
  LoginModel? loginModelObj;
  bool remembermeone;

  @override
  List<Object?> get props =>
      [fullNameController, passwordController, remembermeone, loginModelObj];

  LoginState copywith({
    TextEditingController? fullNameController,
    TextEditingController? passwordController,
    bool? remembermeone,
    LoginModel? loginModelObj,
  }) {
    return LoginState(
      fullNameController: fullNameController ?? this.fullNameController,
      passwordController: passwordController ?? this.passwordController,
      remembermeone: remembermeone ?? this.remembermeone,
      loginModelObj: loginModelObj ?? this.loginModelObj,
    );
  }
}
