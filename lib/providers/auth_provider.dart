import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  
  String? get token => _token;

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }
}
