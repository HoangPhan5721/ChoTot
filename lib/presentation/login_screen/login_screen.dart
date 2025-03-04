import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/login_bloc.dart';
import 'models/login_model.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key})
//       : super(
//           key: key,
//         );
//
//   static Widget builder(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (context) => LoginBloc(LoginState(
//         loginModelObj: LoginModel(),
//       ))
//         ..add(LoginInitialEvent()),
//       child: LoginScreen(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: theme.colorScheme.primaryContainer,
//       // appBar: _buildAppBar(context),
//       body: SafeArea(
//         top: false,
//         child: SizedBox(
//           width: double.maxFinite,
//           child: SingleChildScrollView(
//             child: Container(
//               width: double.maxFinite,
//               padding: EdgeInsets.only(
//                 left: 28.h,
//                 top: 30.h,
//                 right: 28.h,
//               ),
//               // ss
//               child: Column(
//                 children: [
//                   SizedBox(height: 10.h),
//                   CustomImageView(
//                     imagePath: ImageConstant.imgVector,
//                     height: 228.h,
//                     width: 276.h,
//                     alignment: Alignment.centerLeft,
//                     margin: EdgeInsets.only(left: 32.h),
//                   ),
//                   SizedBox(height: 64.h),
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "lbl_welcome".tr,
//                           style: theme.textTheme.displayMedium,
//                         ),
//                         TextSpan(
//                           text: "lbl_plants".tr,
//                           style: CustomTextStyles.displayMediumPrimary,
//                         )
//                       ],
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   Text(
//                     "msg_login_to_your_account".tr,
//                     style: CustomTextStyles.titleSmallPoppinsGray50001,
//                   ),
//                   SizedBox(height: 30.h),
//                   BlocSelector<LoginBloc, LoginState, TextEditingController?>(
//                     selector: (state) => state.fullNameController,
//                     builder: (context, fullNameController) {
//                       return CustomTextFormField(
//                         controller: fullNameController,
//                         hintText: "lbl_full_name".tr,
//                         prefix: Container(
//                           margin: EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
//                           child: CustomImageView(
//                             imagePath: ImageConstant.imgUser,
//                             height: 20.h,
//                             width: 24.h,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         prefixConstraints: BoxConstraints(
//                           maxHeight: 56.h,
//                         ),
//                         contentPadding:
//                             EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
//                         borderDecoration: TextFormFieldStyleHelper.fillGray,
//                         fillcolor: appTheme.gray300,
//                       );
//                     },
//                   ),
//                   SizedBox(height: 18.h),
//                   BlocSelector<LoginBloc, LoginState, TextEditingController?>(
//                     selector: (state) => state.passwordController,
//                     builder: (context, passwordController) {
//                       return CustomTextFormField(
//                         controller: passwordController,
//                         hintText: "lbl_password".tr,
//                         textInputAction: TextInputAction.done,
//                         prefix: Container(
//                           margin: EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
//                           child: CustomImageView(
//                             imagePath: ImageConstant.imgLock,
//                             height: 20.h,
//                             width: 24.h,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         prefixConstraints: BoxConstraints(
//                           maxHeight: 56.h,
//                         ),
//                         obscureText: true,
//                         contentPadding:
//                             EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
//                         borderDecoration: TextFormFieldStyleHelper.fillGray,
//                         fillcolor: appTheme.gray300,
//                       );
//                     },
//                   ),
//                   SizedBox(height: 18.h),
//                   _buildRememberMeRow(context),
//                   SizedBox(height: 76.h),
//                   CustomElevatedButton(
//                     height: 56.h,
//                     text: "Log In",
//                     routeName: '/my_cart_screen', // Navigate to this route
//                     buttonStyle: CustomButtonStyles.fillPrimary,
//                     buttonTextStyle: theme.textTheme.titleLarge!,
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "msg_don_t_have_an_account".tr,
//                         style: CustomTextStyles.labelLargeGray50002,
//                       ),
//                       // Text(
//                       //   "lbl_sign_up".tr,
//                       //   style: CustomTextStyles.labelLargePrimary.copyWith(
//                       //     decoration: TextDecoration.underline,
//                       //   ),
//                       // )
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/register_screen');
//                         },
//                         child: Text(
//                           "lbl_sign_up".tr,
//                           style: CustomTextStyles.labelLargePrimary.copyWith(
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       leadingWidth: 61.h,
//       leading: AppbarLeadingIconbutton(
//         imagePath: ImageConstant.imgArrowLeft,
//         height: 40.h,
//         width: 40.h,
//         margin: EdgeInsets.only(
//           left: 21.h,
//           top: 7.h,
//           bottom: 8.h,
//         ),
//       ),
//     );
//   }
//
//   /// Section Widget
//   Widget _buildRememberMeRow(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       margin: EdgeInsets.only(right: 2.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           BlocSelector<LoginBloc, LoginState, bool?>(
//             selector: (state) => state.remembermeone,
//             builder: (context, remembermeone) {
//               return CustomCheckboxButton(
//                 text: "lbl_remember_me".tr,
//                 value: remembermeone,
//                 onChange: (value) {
//                   context
//                       .read<LoginBloc>()
//                       .add(ChangeCheckBoxEvent(value: value));
//                 },
//               );
//             },
//           ),
//           Text(
//             "msg_forget_password".tr,
//             style: CustomTextStyles.labelLargeBluegray800,
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../../core/app_export.dart';
// import '../../theme/custom_button_style.dart';
// import '../../widgets/custom_checkbox_button.dart';
// import '../../widgets/custom_elevated_button.dart';
// import '../../widgets/custom_text_form_field.dart';
// import 'bloc/login_bloc.dart';
// import 'models/login_model.dart';
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
      backgroundColor: theme.colorScheme.primaryContainer,
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
                          imagePath: ImageConstant.imgVector,
                          height: 228.h,
                          width: 276.h,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 32.h),
                        ),
                        SizedBox(height: 64.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "lbl_welcome".tr,
                                style: theme.textTheme.displayMedium,
                              ),
                              TextSpan(
                                text: "lbl_plants".tr,
                                style: CustomTextStyles.displayMediumPrimary,
                              )
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "msg_login_to_your_account".tr,
                          style: CustomTextStyles.titleSmallPoppinsGray50001,
                        ),
                        SizedBox(height: 30.h),
                        BlocSelector<LoginBloc, LoginState,
                            TextEditingController?>(
                          selector: (state) => state.fullNameController,
                          builder: (context, fullNameController) {
                            return CustomTextFormField(
                              controller: fullNameController,
                              hintText: "lbl_full_name".tr,
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
                              fillcolor: appTheme.gray300,
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
                              fillcolor: appTheme.gray300,
                            );
                          },
                        ),
                        SizedBox(height: 18.h),
                        _buildRememberMeSection(context),
                        SizedBox(height: 52.h),
                        CustomElevatedButton(
                          height: 56.h,
                          text: "lbl_login".tr,
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          buttonTextStyle: theme.textTheme.titleLarge!,
                          onPressed: () {
                            Navigator.pushNamed(context, '/post_screen');
                          },
                        ),

                        SizedBox(height: 22.h),
                        Text(
                          "lbl_or".tr,
                          style: CustomTextStyles.titleSmallGray50002,
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
                              style: CustomTextStyles.labelLargeInterGray50002,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register_screen');
                              },
                              child: Text(
                                "lbl_sign_up".tr,
                                style: CustomTextStyles.labelLargeInterPrimary.copyWith(
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
            style: CustomTextStyles.labelLargeInterBluegray800,
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
