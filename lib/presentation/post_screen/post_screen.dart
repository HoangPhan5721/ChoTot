import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/post_bloc.dart';
import '../post_screen/category_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intern/presentation/post_screen/models/post_model.dart';

enum ItemCondition { newItem, usedItem }

class PostScreen extends StatefulWidget {
  final int? userId;

  const PostScreen({Key? key, this.userId}) : super(key: key);

  static Widget builder(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int? userId = args?['userId'] as int?;
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc()..add(PostInitialEvent()),
      child: PostScreen(userId: userId),
    );
  }

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  ItemCondition? _condition = ItemCondition.newItem;

  Future<void> _submitPost(BuildContext context) async {
    final state = context.read<PostBloc>().state;

    // Validate required fields
    // if (widget.userId == null ||
    //     state.selectedCategoryId == null ||
    //     (state.titleController == null || state.titleController!.text.isEmpty) ||
    //     (state.productNameController == null || state.productNameController!.text.isEmpty) ||
    //     (state.descriptionController == null || state.descriptionController!.text.isEmpty) ||
    //     (state.priceController == null || state.priceController!.text.isEmpty) ||
    //     (state.locationController == null || state.locationController!.text.isEmpty)) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please fill all required fields')),
    //   );
    //   return;
    // }

    // Prepare form data
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://nodejs-cgor.onrender.com/api/posts'),
    );

    request.fields['user_id'] = widget.userId.toString();
    request.fields['category_id'] = state.selectedCategoryId.toString();
    request.fields['title'] = state.titleController!.text;
    request.fields['product_name'] = state.productNameController!.text;
    request.fields['description'] = state.descriptionController!.text;
    request.fields['price'] = state.priceController!.text;
    request.fields['location'] = state.locationController!.text;
    request.fields['product_status'] = _condition == ItemCondition.newItem ? 'Mới' : 'Đã qua sử dụng';

    if (state.imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('images', state.imageFile!.path));
    }

    // Print the data being sent to the API
    print('Posting to API:');
    print('URL: ${request.url}');
    print('Fields: ${request.fields}');
    if (state.imageFile != null) {
      print('Image file path: ${state.imageFile!.path}');
    } else {
      print('No image file included');
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('API Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Post created successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        // Navigate to /homepage_screen instead of popping
        Navigator.pushReplacementNamed(context, '/homepage_screen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post: $responseBody')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("UserID in PostScreen: ${widget.userId}");
    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 74.h),
                  _buildTitleInputSection(context),
                  SizedBox(height: 32.h),
                  _buildCategory(context),
                  SizedBox(height: 32.h),
                  _buildProductName(context),
                  SizedBox(height: 32.h),
                  _buildImageUploadSection(context),
                  SizedBox(height: 32.h),
                  _buildDescription(context),
                  SizedBox(height: 32.h),
                  _buildPriceInputSection(context),
                  SizedBox(height: 32.h),
                  _buildLocationInputSection(context),
                  SizedBox(height: 32.h),
                  _buildConditionRadios(context),
                  SizedBox(height: 32.h),
                  _buildCtaButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 67.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 37.h, top: 14.h, bottom: 11.h),
        onTap: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: AppbarTitle(text: "lbl_post".tr),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMoreVertical,
          margin: EdgeInsets.only(right: 25.h),
        ),
      ],
    );
  }

  Widget _buildTitleInputSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl_title".tr, style: theme.textTheme.labelLarge),
          SizedBox(height: 8.h),
          BlocSelector<PostBloc, PostState, TextEditingController?>(
            selector: (state) => state.titleController,
            builder: (context, titleController) {
              return CustomTextFormField(
                controller: titleController,
                hintText: "lbl_enter_title".tr,
                contentPadding: EdgeInsets.all(16.h),
                borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
                fillColor: theme.colorScheme.primaryContainer,
                onChanged: (value) {
                  context.read<PostBloc>().add(TitleChangedEvent(value));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(BuildContext context) {
    return CategoryWidget(
      onCategorySelected: (categoryId, categoryName) {
        context.read<PostBloc>().add(CategorySelectedEvent(categoryId, categoryName));
      },
    );
  }

  Widget _buildProductName(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl_productname".tr, style: theme.textTheme.labelLarge),
          SizedBox(height: 8.h),
          BlocSelector<PostBloc, PostState, TextEditingController?>(
            selector: (state) => state.productNameController,
            builder: (context, productNameController) {
              return CustomTextFormField(
                controller: productNameController,
                hintText: "lbl_enter_product_name".tr,
                contentPadding: EdgeInsets.all(16.h),
                borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
                fillColor: theme.colorScheme.primaryContainer,
                onChanged: (value) {
                  context.read<PostBloc>().add(ProductNameChangedEvent(value));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl_description".tr, style: theme.textTheme.labelLarge),
          SizedBox(height: 8.h),
          BlocSelector<PostBloc, PostState, TextEditingController?>(
            selector: (state) => state.descriptionController,
            builder: (context, descriptionController) {
              return CustomTextFormField(
                controller: descriptionController,
                hintText: "lbl_typing".tr,
                hintStyle: CustomTextStyles.bodyLargeOnPrimaryContainer,
                maxLines: 4,
                contentPadding: EdgeInsets.all(16.h),
                borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
                fillColor: theme.colorScheme.primaryContainer,
                onChanged: (value) {
                  context.read<PostBloc>().add(DescriptionChangedEvent(value));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInputSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl_price".tr, style: theme.textTheme.labelLarge),
          SizedBox(height: 8.h),
          BlocSelector<PostBloc, PostState, TextEditingController?>(
            selector: (state) => state.priceController,
            builder: (context, priceController) {
              return CustomTextFormField(
                controller: priceController,
                hintText: "lbl_enter_price".tr,
                contentPadding: EdgeInsets.all(16.h),
                borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
                fillColor: theme.colorScheme.primaryContainer,
                // keyboardType: TextInputType.number,
                onChanged: (value) {
                  context.read<PostBloc>().add(PriceChangedEvent(value));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInputSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl_location".tr, style: theme.textTheme.labelLarge),
          SizedBox(height: 8.h),
          BlocSelector<PostBloc, PostState, TextEditingController?>(
            selector: (state) => state.locationController,
            builder: (context, locationController) {
              return CustomTextFormField(
                controller: locationController,
                hintText: "msg_enter_location".tr,
                textInputAction: TextInputAction.done,
                maxLines: 2,
                contentPadding: EdgeInsets.fromLTRB(16.h, 16.h, 16.h, 12.h),
                borderDecoration: TextFormFieldStyleHelper.getOutlineBlueGray,
                fillColor: theme.colorScheme.primaryContainer,
                onChanged: (value) {
                  context.read<PostBloc>().add(LocationChangedEvent(value));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl_upload_image".tr, style: theme.textTheme.labelLarge),
          SizedBox(height: 8.h),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    context.read<PostBloc>().add(ImageSelectedEvent(File(pickedFile.path)));
                  }
                },
                child: Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8.h),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: state.imageFile != null
                      ? Image.file(state.imageFile!, fit: BoxFit.cover)
                      : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50.h, color: Colors.grey),
                        SizedBox(height: 8.h),
                        Text("lbl_select_image".tr, style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConditionRadios(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl_product_status".tr, style: theme.textTheme.labelLarge),
          SizedBox(height: 8.h),
          Row(
            children: [
              Radio<ItemCondition>(
                value: ItemCondition.newItem,
                groupValue: _condition,
                onChanged: (value) {
                  setState(() {
                    _condition = value;
                  });
                },
              ),
              Text("Mới", style: theme.textTheme.bodyMedium),
              SizedBox(width: 16.h),
              Radio<ItemCondition>(
                value: ItemCondition.usedItem,
                groupValue: _condition,
                onChanged: (value) {
                  setState(() {
                    _condition = value;
                  });
                },
              ),
              Text("Đã qua sử dụng", style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCtaButtons(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h, right: 6.h),
      child: CustomElevatedButton(
        text: "lbl_submit_post".tr,
        onPressed: () => _submitPost(context),
        buttonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0047AB)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // ✅ Ensures text is white
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.h),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar();
  }
}
