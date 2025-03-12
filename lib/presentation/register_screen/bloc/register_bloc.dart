import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:intern/core/app_export.dart';
import 'package:intern/presentation/register_screen/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'register_event.dart';
part 'register_state.dart';

/// A bloc that manages the state of a Register according to the event that is dispatched to it.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterState initialState) : super(initialState) {
    on<RegisterInitialEvent>(_onInitialize);
    on<RegisterSubmitEvent>(_onSubmit); // Handler cho sự kiện submit
  }

  _onInitialize(
      RegisterInitialEvent event,
      Emitter<RegisterState> emit,
      ) async {
    emit(
      state.copyWith(
        fullNameInputController: TextEditingController(),
        emailInputController: TextEditingController(),
        passwordInputController: TextEditingController(),
        confirmPasswordInputController: TextEditingController(),
      ),
    );
  }

  _onSubmit(
      RegisterSubmitEvent event,
      Emitter<RegisterState> emit,
      ) async {
    // Bắt đầu loading
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    try {
      // Gọi API đăng ký
      final response = await _registerUser(event.email, event.password, event.phone);

      // Kiểm tra kết quả từ API
      if (response['status'] == 201) {
        // Thành công
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true, // Đặt isSuccess = true khi thành công
          errorMessage: null,
        ));
      } else {
        // Thất bại
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: response['message'] ?? "Đăng ký thất bại",
        ));
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: "Lỗi kết nối: $e",
      ));
    }
  }

  /// API Call for Registration
  Future<Map<String, dynamic>> _registerUser(String email, String password, String phone) async {
    final url = Uri.parse("https://nodejs-cgor.onrender.com/api/signup");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"email": email, "phone": phone, "password": password});

    print("Sending request to: $url");
    print("Request Headers: $headers");
    print("Request Body: $body");

    try {
      final response = await http.post(url, headers: headers, body: body);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      return jsonDecode(response.body); // Trả về Map<String, dynamic>
    } catch (e) {
      print("Error: $e");
      return {"status": 500, "message": "Có lỗi xảy ra"};
    }
  }
}
