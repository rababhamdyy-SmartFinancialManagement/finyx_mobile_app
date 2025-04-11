import 'package:flutter/material.dart';

class LoginModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  void toggleRememberMe(bool? value) {
    isChecked = value ?? false;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
