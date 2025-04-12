import 'dart:convert';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpModel {
  bool isIndividual = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Dispose the controllers when done
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
  }

  // Function to handle user registration
  Future<UserType?> registerUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final phoneNumber = phoneNumberController.text.trim();

    // Check for empty inputs
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || phoneNumber.isEmpty) {
      CustomSnackbar.show(context, "All fields must be filled", isError: true);
      return null;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      CustomSnackbar.show(context, "Passwords do not match", isError: true);
      return null;
    }

    try {
      // Temporary API call is commented for now
      /*
      final response = await http.post(
        Uri.parse("https://your.api/register"), // Replace with your API URL
        body: {
          "email": email,
          "password": password,
          "phone_number": phoneNumber,
          "user_type": isIndividual ? "individual" : "business", // Send the user type
        },
      );
      */

      // For now we simulate a successful response as if it was from an API
      final response = {"status": "success", "user_type": isIndividual ? "individual" : "business"};

      if (response['status'] == 'success') {
        final userType = response["user_type"];

        if (userType == null) {
          CustomSnackbar.show(context, "User type not found", isError: true);
          return null;
        }

        // Handle user type and save it to SharedPreferences
        if (userType == "individual") {
          await SharedPrefsHelper.saveUserType("individual");
          CustomSnackbar.show(context, "Registered as Individual", isError: false);
          return UserType.individual;
        } else if (userType == "business") {
          await SharedPrefsHelper.saveUserType("business");
          CustomSnackbar.show(context, "Registered as Business", isError: false);
          return UserType.business;
        } else {
          CustomSnackbar.show(context, "Unknown user type", isError: true);
          return null;
        }
      } else {
        CustomSnackbar.show(context, "Registration failed: ${response['status']}", isError: true);
      }
    } catch (e) {
      CustomSnackbar.show(context, "Error during registration: $e", isError: true);
    }

    return null;
  }
}
