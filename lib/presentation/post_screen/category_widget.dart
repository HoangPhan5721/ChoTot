import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/app_export.dart';

class CategoryWidget extends StatefulWidget {
  final Function(int, String) onCategorySelected;
  const CategoryWidget({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Category> _categories = [];
  Category? _selectedCategory;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse('https://nodejs-cgor.onrender.com/api/categories/all'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          setState(() {
            _categories = (jsonResponse['data'] as List)
                .map((item) => Category.fromJson(item))
                .toList();
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_category".tr,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 8.h),
          _isLoading
              ? SizedBox(
            height: 40.h,
            child: Center(child: CircularProgressIndicator()),
          )
              : DropdownButtonFormField<Category>(
            value: _selectedCategory,
            hint: Text("lbl_select_category".tr),
            items: _categories.map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (Category? newValue) {
              setState(() {
                _selectedCategory = newValue;
                if (newValue != null) {
                  widget.onCategorySelected(newValue.id, newValue.name);
                }
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.h),
              ),
              filled: true,
              fillColor: theme.colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String description;

  Category({required this.id, required this.name, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
