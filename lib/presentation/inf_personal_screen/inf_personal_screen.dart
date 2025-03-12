import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/inf_personal_bloc.dart';
import 'model/inf_personal_model.dart';
import 'bloc/inf_personal_state.dart';
import 'bloc/inf_personal_event.dart';

class InfPersonalScreen extends StatefulWidget {
  const InfPersonalScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<InfPersonalBloc>(
      create: (context) => InfPersonalBloc()..add(InfPersonalInitialEvent()),
      child: const InfPersonalScreen(),
    );
  }

  @override
  _InfPersonalScreenState createState() => _InfPersonalScreenState();
}

class _InfPersonalScreenState extends State<InfPersonalScreen> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _ratingController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _ratingController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfPersonalBloc, InfPersonalState>(
      builder: (context, state) {
        final model = state.infPersonalModelObj;
        if (!_isEditing) {
          _nameController.text = model.name;
          _emailController.text = model.email;
          _addressController.text = model.address;
          _phoneController.text = model.phone;
          _ratingController.text = model.rating.toString();
        }
        return Scaffold(
          backgroundColor: theme.colorScheme.primaryContainer,
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: model.avatarUrl,
                      height: 154.h,
                      width: 160.h,
                      fit: BoxFit.cover,
                      placeHolder: ImageConstant.imgAvatar,
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEditing = !_isEditing;
                              });
                            },
                            child: CustomImageView(
                              imagePath: _isEditing ? ImageConstant.imgCheckmark : ImageConstant.imgEdit,
                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (state.isLoading)
                      const CircularProgressIndicator()
                    else if (state.error != null)
                      Text(state.error!, style: theme.textTheme.bodyMedium)
                    else
                      _buildPersonalInfo(context, model),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 50.h,
      leadingWidth: 40.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 10.h, top: 10.h, bottom: 10.h),
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildPersonalInfo(BuildContext context, InfPersonalModel model) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.h),
      decoration: AppDecoration.lightGray0.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(context, "lbl_name".tr, ImageConstant.in4user, _nameController),
          SizedBox(height: 16.h),
          _buildInfoRow(context, "lbl_email".tr, ImageConstant.in4email, _emailController),
          SizedBox(height: 16.h),
          _buildInfoRow(context, "lbl_address".tr, ImageConstant.in4location, _addressController),
          SizedBox(height: 16.h),
          _buildInfoRow(context, "lbl_phone".tr, ImageConstant.in4phone, _phoneController),
          SizedBox(height: 16.h),
          _buildInfoRow(context, "lbl_rating".tr, ImageConstant.in4review, _ratingController),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String iconPath, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: iconPath,
          height: 24.h,
          width: 24.h,
        ),
        SizedBox(width: 12.h),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium,
              ),
              _isEditing
                  ? Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200.h),
                  child: TextField(
                    controller: controller,
                    style: CustomTextStyles.bodyMediumBlueA400,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintStyle: CustomTextStyles.bodyMediumBlueA400, // Ensure hint matches
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              )
                  : Text(
                controller.text,
                style: CustomTextStyles.bodyMediumBlueA400,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
