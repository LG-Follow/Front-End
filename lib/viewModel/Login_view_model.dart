// viewmodels/login_view_model.dart
import 'package:flutter/material.dart';
import '../model/Login.dart';

class LoginViewModel with ChangeNotifier {
  Login _login = Login();
  bool _isPasswordVisible = false;


  String emailOrPhone = 'alsrb595@naver.com';
  String password = 'bigguy';

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
