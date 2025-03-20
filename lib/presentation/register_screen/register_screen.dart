import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/register_bloc.dart';
import 'models/register_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(RegisterState(
        registerModelObj: RegisterModel(),
      ))..add(RegisterInitialEvent()),
      child: const RegisterScreen(),
    );
  }

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Số điện thoại không được để trống";
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return "Vui lòng nhập số điện thoại 10 chữ số hợp lệ";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email không được để trống";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Vui lòng nhập địa chỉ email hợp lệ";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Mật khẩu không được để trống";
    }
    if (value.length < 8) {
      return "Mật khẩu phải dài ít nhất 8 ký tự";
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$').hasMatch(value)) {
      return "Mật khẩu phải chứa cả chữ cái và số";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Xác nhận mật khẩu không được để trống";
    }
    if (value != passwordController.text) {
      return "Mật khẩu không khớp";
    }
    return null;
  }

  void _validateForm() {
    // Trigger validation and update UI
    setState(() {
      _formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              // Optionally set autovalidateMode for continuous validation
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 26.h, top: 30.h, right: 26.h),
                child: Column(
                  children: [
                    SizedBox(height: 46.h),
                    Text("lbl_register".tr, style: CustomTextStyles.displayMediumInterOnPrimary),
                    Text("msg_create_your_new".tr, style: CustomTextStyles.titleLargeInterGray50003),
                    SizedBox(height: 24.h),
                    _buildPhoneInput(context),
                    SizedBox(height: 22.h),
                    _buildEmailInput(context),
                    SizedBox(height: 22.h),
                    _buildPasswordInput(context),
                    SizedBox(height: 22.h),
                    _buildConfirmPasswordInput(context),
                    SizedBox(height: 24.h),
                    Text("msg_by_signing_you_agree".tr, style: CustomTextStyles.titleSmallGray500),
                    Text("msg_and_privacy_notice".tr, style: CustomTextStyles.titleSmallGray500),
                    SizedBox(height: 142.h),
                    _buildSignUpButton(context),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("msg_already_have_an".tr, style: CustomTextStyles.labelLargeGray50002),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/login_screen'),
                          child: Text(
                            "lbl_login".tr,
                            style: CustomTextStyles.labelLargePrimary.copyWith(
                              decoration: TextDecoration.underline,
                              color: const Color(0xFF0047AB),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: CustomTextFormField(
        controller: phoneController,
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
        prefixConstraints: BoxConstraints(maxHeight: 58.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
        borderDecoration: TextFormFieldStyleHelper.fillGray,
        fillColor: Colors.white,
        validator: _validatePhone,
        onChanged: (value) => _validateForm(), // Validate in real-time
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: CustomTextFormField(
        controller: emailController,
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
        prefixConstraints: BoxConstraints(maxHeight: 56.h),
        contentPadding: EdgeInsets.fromLTRB(18.h, 16.h, 12.h, 16.h),
        borderDecoration: TextFormFieldStyleHelper.fillGray,
        fillColor: Colors.white,
        validator: _validateEmail,
        onChanged: (value) => _validateForm(), // Validate in real-time
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: CustomTextFormField(
        controller: passwordController,
        hintText: "lbl_password".tr,
        textInputAction: TextInputAction.next,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(18.h, 16.h, 14.h, 16.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgLock,
            height: 24.h,
            width: 24.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixConstraints: BoxConstraints(maxHeight: 58.h),
        obscureText: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
        borderDecoration: TextFormFieldStyleHelper.fillGray,
        fillColor: Colors.white,
        validator: _validatePassword,
        onChanged: (value) => _validateForm(), // Validate in real-time
      ),
    );
  }

  Widget _buildConfirmPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: CustomTextFormField(
        controller: confirmPasswordController,
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
        prefixConstraints: BoxConstraints(maxHeight: 58.h),
        obscureText: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
        borderDecoration: TextFormFieldStyleHelper.fillGray,
        fillColor: Colors.white,
        validator: _validateConfirmPassword,
        onChanged: (value) => _validateForm(), // Validate in real-time
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đăng ký thành công!")),
          );
          Navigator.pushReplacementNamed(context, '/login_screen');
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          height: 56.h,
          text: "lbl_sign_up".tr,
          margin: EdgeInsets.only(left: 2.h),
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0047AB),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          buttonTextStyle: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
          child: state.isLoading
              ? SizedBox(
            height: 24.h,
            width: 24.h,
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3.0,
            ),
          )
              : null,
          onPressed: state.isLoading
              ? null
              : () {
            if (_formKey.currentState!.validate()) {
              final registerBloc = context.read<RegisterBloc>();
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              final phone = phoneController.text.trim();
              registerBloc.add(RegisterSubmitEvent(email, password, phone));
            }
          },
        );
      },
    );
  }
}
