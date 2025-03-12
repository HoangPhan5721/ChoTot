import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_checkbox_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/login_bloc.dart';
import 'models/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginState(
        loginModelObj: LoginModel(),
      ))..add(LoginInitialEvent()),
      child: const LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      emailError = _validateEmail(emailController.text.trim());
      passwordError = _validatePassword(passwordController.text.trim());
    });

    if (emailError != null || passwordError != null) return;

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("https://nodejs-cgor.onrender.com/api/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final responseData = jsonDecode(response.body);
      String? token = responseData["metadata"]?["token"]?["accessToken"];
      int? userId = responseData["metadata"]?["user"]?["userId"]; // Extract userId

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (token != null) {
          // Navigator.pushNamed(context, '/homepage_screen');
          Navigator.pushNamed(
              context,
              '/post_screen',
              arguments: {'userId': userId},);
        } else {
          setState(() => emailError = "Invalid email or password");
        }
      } else {
        setState(() => emailError = responseData["error"] ?? "Login failed");
      }
    } catch (e) {
      isLoading.value = false;
      setState(() => emailError = "An error occurred. Please try again.");
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return "Email cannot be empty";
    }
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return "Please enter a valid email (e.g., example@domain.com)";
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0047AB),
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(left: 24.h, top: 18.h, right: 24.h),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 6.h),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgLogo,
                          height: 228.h,
                          width: 276.h,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 32.h),
                        ),
                        SizedBox(height: 30.h),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: "lbl_email".tr,
                          prefix: Container(
                            margin: EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgUser,
                              height: 22.h,
                              width: 24.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          prefixConstraints: BoxConstraints(maxHeight: 56.h),
                          contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
                          borderDecoration: TextFormFieldStyleHelper.fillGray,
                          fillColor: Colors.white,
                          errorText: emailError, // Assuming CustomTextFormField supports this
                        ),
                        SizedBox(height: 18.h),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: "lbl_password".tr,
                          textInputAction: TextInputAction.done,
                          prefix: Container(
                            margin: EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgLock,
                              height: 22.h,
                              width: 24.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          prefixConstraints: BoxConstraints(maxHeight: 56.h),
                          obscureText: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
                          borderDecoration: TextFormFieldStyleHelper.fillGray,
                          fillColor: Colors.white,
                          errorText: passwordError, // Assuming CustomTextFormField supports this
                        ),
                        SizedBox(height: 18.h),
                        _buildRememberMeSection(context),
                        SizedBox(height: 40.h),
                        CustomElevatedButton(
                          height: 56.h,
                          text: "lbl_login".tr,
                          buttonStyle: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.h),
                              ),
                            ),
                          ),
                          buttonTextStyle: const TextStyle(
                            color: Color(0xFF0047AB),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: _login,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: isLoading,
                            builder: (context, loading, child) {
                              return loading
                                  ? SizedBox(
                                width: 24.h,
                                height: 24.h,
                                child: const CircularProgressIndicator(
                                  color: Color(0xFF0047AB),
                                  strokeWidth: 3,
                                ),
                              )
                                  : Text(
                                "lbl_login".tr,
                                style: const TextStyle(
                                  color: Color(0xFF0047AB),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          "lbl_or".tr,
                          style: CustomTextStyles.titleSmallGray50002.copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(indent: 22.h, endIndent: 18.h),
                        ),
                        SizedBox(height: 10.h),
                        _buildSocialMediaIcons(context),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "msg_don_t_have_an_account".tr,
                              style: CustomTextStyles.labelLargeInterGray50002.copyWith(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register_screen');
                              },
                              child: Text(
                                "lbl_sign_up".tr,
                                style: CustomTextStyles.labelLargeInterPrimary.copyWith(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocSelector<LoginBloc, LoginState, bool?>(
            selector: (state) => state.remembermeone,
            builder: (context, remembermeone) {
              return CustomCheckboxButton(
                text: "lbl_remember_me".tr,
                value: remembermeone,
                textStyle: const TextStyle(color: Colors.white),
                onChange: (value) {
                  context.read<LoginBloc>().add(ChangeCheckBoxEvent(value: value));
                },
              );
            },
          ),
          Text(
            "msg_forget_password".tr,
            style: CustomTextStyles.labelLargeInterBluegray800.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcons(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgGoogle,
            height: 60.h,
            width: 62.h,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgFacebook,
            height: 60.h,
            width: 62.h,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgDiscord,
            height: 60.h,
            width: 62.h,
          ),
        ],
      ),
    );
  }
}
