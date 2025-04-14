import 'dart:convert';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
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

  Future<UserType?> loginUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Check for empty inputs
    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.show(context, "Email or password cannot be empty", isError: true);
      return null;
    }

    try {
      // Dummy data (static values for testing purposes)
      final dummyEmail = "shahd.mohamed@madar.it";
      final dummyPassword = "shahd12";

      // Check if the entered email and password match the dummy values
      if (email == dummyEmail && password == dummyPassword) {
        // Simulate a successful login response
        final userType = "individual"; // Replace with dynamic user type based on actual logic

        if (userType == null) {
          CustomSnackbar.show(context, "User type not found", isError: true);
          return null;
        }

        // Handle user type and save it to SharedPreferences
        if (userType == "individual") {
          await SharedPrefsHelper.saveUserType("individual");
          CustomSnackbar.show(context, "Logged in as Individual", isError: false);
          
          // Show message if Remember Me is checked
          if (isChecked) {
            CustomSnackbar.show(context, "You will be remembered!", isError: false);
          }

          return UserType.individual;
        } else if (userType == "business") {
          await SharedPrefsHelper.saveUserType("business");
          CustomSnackbar.show(context, "Logged in as Business", isError: false);

          // Show message if Remember Me is checked
          if (isChecked) {
            CustomSnackbar.show(context, "You will be remembered!", isError: false);
          }

          return UserType.business;
        } else {
          CustomSnackbar.show(context, "Unknown user type", isError: true);
          return null;
        }
      } else {
        CustomSnackbar.show(context, "Invalid email or password", isError: true);
      }
    } catch (e) {
      CustomSnackbar.show(context, "Error during login: $e", isError: true);
    }

    return null;
  }
}
