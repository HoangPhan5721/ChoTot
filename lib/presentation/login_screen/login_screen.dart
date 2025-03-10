import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/login_bloc.dart';
import 'models/login_model.dart';

void _login(BuildContext context, TextEditingController emailController,
    TextEditingController passwordController) async {
  final String apiUrl = "https://nodejs-cgor.onrender.com/api/login";
  final String email = emailController.text.trim();
  final String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    _showErrorDialog(context, "Please enter both email and password.");
    return;
  }

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    print("API URL: $apiUrl");
    print("Email: $email");
    print("Password: $password"); // Không in ra trong môi trường production
    final responseData = jsonDecode(response.body);
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    String? token = responseData["metadata"]["token"]["accessToken"];
    if (token == null) {
      _showErrorDialog(context, "Token not received.");
    } else {
      print("Access Token: $token");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (responseData["message"] == "Successfully logged in!") {
        Navigator.pushNamed(context, '/homepage_screen');
      } else {
        _showErrorDialog(context, "Invalid email or password.");
      }
    } else {
      _showErrorDialog(context, responseData["error"] ?? "Login failed.");
    }
  } catch (e) {
    _showErrorDialog(context, "An error occurred. Please try again.");
  }
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Login Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginState(
        loginModelObj: LoginModel(),
      ))
        ..add(LoginInitialEvent()),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: theme.colorScheme.primaryContainer,
      backgroundColor: Color(0xFF0047AB),
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 24.h,
                top: 18.h,
                right: 24.h,
              ),
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
                        // SizedBox(height: 64.h),
                        // RichText(
                        //   text: TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: "lbl_welcome".tr,
                        //         style: theme.textTheme.displayMedium,
                        //       ),
                        //       TextSpan(
                        //         text: "lbl_plants".tr,
                        //         style: CustomTextStyles.displayMediumPrimary,
                        //       )
                        //     ],
                        //   ),
                        //   textAlign: TextAlign.left,
                        // ),
                        // Text(
                        //   "msg_login_to_your_account".tr,
                        //   style: CustomTextStyles.titleSmallPoppinsGray50001,
                        // ),
                        SizedBox(height: 30.h),
                        BlocSelector<LoginBloc, LoginState,
                            TextEditingController?>(
                          selector: (state) => state.fullNameController,
                          builder: (context, fullNameController) {
                            return CustomTextFormField(
                              controller: fullNameController,
                              hintText: "lbl_email".tr,
                              prefix: Container(
                                margin:
                                    EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgUser,
                                  height: 22.h,
                                  width: 24.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              prefixConstraints: BoxConstraints(
                                maxHeight: 56.h,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 18.h,
                                vertical: 16.h,
                              ),
                              borderDecoration:
                                  TextFormFieldStyleHelper.fillGray,
                              // fillcolor: appTheme.gray300,
                              fillcolor: Colors.white,
                            );
                          },
                        ),
                        SizedBox(height: 18.h),
                        BlocSelector<LoginBloc, LoginState,
                            TextEditingController?>(
                          selector: (state) => state.passwordController,
                          builder: (context, passwordController) {
                            return CustomTextFormField(
                              controller: passwordController,
                              hintText: "lbl_password".tr,
                              textInputAction: TextInputAction.done,
                              prefix: Container(
                                margin:
                                    EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgLock,
                                  height: 22.h,
                                  width: 24.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              prefixConstraints: BoxConstraints(
                                maxHeight: 56.h,
                              ),
                              obscureText: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 18.h,
                                vertical: 16.h,
                              ),
                              borderDecoration:
                                  TextFormFieldStyleHelper.fillGray,
                              // fillcolor: appTheme.gray300,
                              fillcolor: Colors.white,
                            );
                          },
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
                          buttonTextStyle: TextStyle(
                            color: Color(0xFF0047AB),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            final fullNameController = context.read<LoginBloc>().state.fullNameController!;
                            final passwordController = context.read<LoginBloc>().state.passwordController!;
                            _login(context, fullNameController, passwordController);
                          },
                        ),

                        SizedBox(height: 22.h),
                        Text(
                          "lbl_or".tr,
                          style: CustomTextStyles.titleSmallGray50002.copyWith(color: Colors.white),

                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            indent: 22.h,
                            endIndent: 18.h,
                          ),
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
                              style: CustomTextStyles.labelLargeInterGray50002.copyWith(color:Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/register_screen');
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
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
                textStyle: TextStyle(color: Colors.white),
                onChange: (value) {
                  context
                      .read<LoginBloc>()
                      .add(ChangeCheckBoxEvent(value: value));
                },
              );
            },
          ),
            Text(
              "msg_forget_password".tr,
              // style: CustomTextStyles.labelLargeInterBluegray800,
              style: CustomTextStyles.labelLargeInterBluegray800.copyWith(color: Colors.white),
            )
        ],
      ),
    );
  }

  /// Section Widget
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
          )
        ],
      ),
    );
  }
}
