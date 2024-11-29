// 로그인 기능

import 'package:flutter/material.dart';
import '../model/Login.dart';

class LoginViewModel with ChangeNotifier {
  Login _login = Login();
  bool _isPasswordVisible = false;


  String emailOrPhone = '123';
  String password = '123';

  bool get isPasswordVisible => _isPasswordVisible;

  void setEmailOrPhone(String value) {
    _login.emailOrPhone = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _login.password = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool validateCredentials() {
    return emailOrPhone.isNotEmpty && password.isNotEmpty;
  }
}
