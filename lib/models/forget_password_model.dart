import 'package:flutter/material.dart';

class ForgetPasswordModel {
  final TextEditingController emailController = TextEditingController();

  void dispose() {
    emailController.dispose();
  }
}
