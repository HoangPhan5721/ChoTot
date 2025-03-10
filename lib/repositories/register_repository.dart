import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterRepository {
  Future<ApiResponse> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("https://your-api.com/register");
    final response = await http.post(
      url,
      body: jsonEncode({
        "fullName": fullName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return ApiResponse(success: true);
    } else {
      return ApiResponse(success: false, errorMessage: "Registration failed.");
    }
  }
}

class ApiResponse {
  final bool success;
  final String? errorMessage;

  ApiResponse({required this.success, this.errorMessage});
}
