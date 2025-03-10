import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton_one.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/register_bloc.dart';
import 'models/register_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key})
      : super(
    key: key,
  );

  static Widget builder(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(RegisterState(
        registerModelObj: RegisterModel(),
      ))
        ..add(RegisterInitialEvent()),
      child: RegisterScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      // appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 26.h,
                top: 30.h,
                right: 26.h,
              ),
              child: Column(
                children: [
                  SizedBox(height: 46.h),
                  Text(
                    "lbl_register".tr,
                    style: CustomTextStyles.displayMediumInterOnPrimary,
                  ),
                  Text(
                    "msg_create_your_new".tr,
                    style: CustomTextStyles.titleLargeInterGray50003,
                  ),
                  SizedBox(height: 24.h),
                  _buildFullNameInput(context),
                  SizedBox(height: 22.h),
                  _buildEmailInput(context),
                  SizedBox(height: 22.h),
                  _buildPasswordInput(context),
                  SizedBox(height: 22.h),
                  _buildConfirmPasswordInput(context),
                  SizedBox(height: 24.h),
                  Text(
                    "msg_by_signing_you_agree".tr,
                    style: CustomTextStyles.titleSmallGray500,
                  ),
                  Text(
                    "msg_and_privacy_notice".tr,
                    style: CustomTextStyles.titleSmallGreen300,
                  ),
                  SizedBox(height: 142.h),
                  _buildSignUpButton(context),
                  SizedBox(height: 18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "msg_already_have_an".tr,
                        style: CustomTextStyles.labelLargeGray50002,
                      ),
                      // Text(
                      //   "lbl_login".tr,
                      //   style: CustomTextStyles.labelLargePrimary.copyWith(
                      //     decoration: TextDecoration.underline,
                      //   ),
                      // )
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login_screen');
                        },
                        child: Text(
                          "lbl_login".tr,
                          style: CustomTextStyles.labelLargePrimary.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                    ],
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 76.h,
      leading: AppbarLeadingIconbuttonOne(
        imagePath: ImageConstant.imgArrowLeft,
        height: 40.h,
        width: 40.h,
        margin: EdgeInsets.only(
          left: 36.h,
          top: 7.h,
          bottom: 8.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFullNameInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.fullNameInputController,
        builder: (context, fullNameInputController) {
          return CustomTextFormField(
            controller: fullNameInputController,
            hintText: "lbl_phone".tr,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(18.h, 16.h, 14.h, 16.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgUser,
                height: 24.h,
                width: 24.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 58.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.h,
              vertical: 16.h,
            ),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.emailInputController,
        builder: (context, emailInputController) {
          return CustomTextFormField(
            controller: emailInputController,
            hintText: "lbl_email".tr,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgEmail,
                height: 20.h,
                width: 16.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 56.h,
            ),
            contentPadding: EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.passwordInputController,
        builder: (context, passwordInputController) {
          return CustomTextFormField(
            controller: passwordInputController,
            hintText: "lbl_password".tr,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(18.h, 16.h, 14.h, 16.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgLock,
                height: 24.h,
                width: 24.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 58.h,
            ),
            obscureText: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.h,
              vertical: 16.h,
            ),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
        selector: (state) => state.confirmPasswordInputController,
        builder: (context, confirmPasswordInputController) {
          return CustomTextFormField(
            controller: confirmPasswordInputController,
            hintText: "msg_confirm_password".tr,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(18.h, 16.h, 14.h, 16.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgLock,
                height: 24.h,
                width: 24.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 58.h,
            ),
            obscureText: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.h,
              vertical: 16.h,
            ),
          );
        },
      ),
    );
  }
  Future<Map<String, dynamic>> _registerUser(String email, String password, String phone) async {
    final url = Uri.parse("https://nodejs-cgor.onrender.com/api/signup");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "phone": phone,
      "password": password,
    });

    print("Sending request to: $url");
    print("Request Headers: $headers");
    print("Request Body: $body");

    try {
      final response = await http.post(url, headers: headers, body: body);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print("Error: $e");
      return {"status": 500, "message": "Something went wrong"};
    }
  }


  /// Section Widget
  Widget _buildSignUpButton(BuildContext context) {
    return CustomElevatedButton(
      height: 56.h,
      text: "lbl_sign_up".tr,
      margin: EdgeInsets.only(left: 2.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: theme.textTheme.titleLarge!,
      onPressed: () async {
        final registerBloc = context.read<RegisterBloc>();
        final email = registerBloc.state.emailInputController?.text.trim() ?? "";
        final password = registerBloc.state.passwordInputController?.text.trim() ?? "";
        final phone = registerBloc.state.fullNameInputController?.text.trim() ?? "";

        if (email.isEmpty || password.isEmpty || phone.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please fill all fields!")),
          );
          return;
        }

        final response = await _registerUser(email, password, phone);
        if (response['status'] == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'])),
          );
          Navigator.pushNamed(context, '/login_screen'); // Navigate to login screen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration failed! Try again.")),
          );
        }
      },
    );
  }

}
