import 'dart:convert';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpModel {
  bool isIndividual = true; // أو يمكنك تحديد القيمة من خلال واجهة المستخدم
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
      // Firebase Authentication for user registration
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user details to Firestore without storing password
      final user = userCredential.user;
      if (user != null) {
        final userRef = FirebaseFirestore.instance.collection(isIndividual ? 'individuals' : 'businesses').doc(user.uid);

        // Save user data in Firestore (excluding password)
        await userRef.set({
          'email': email,
          'phoneNumber': phoneNumber,
          'userType': isIndividual ? 'individual' : 'business',
        });

        // Save userType to SharedPreferences
        await SharedPrefsHelper.saveUserType(isIndividual ? 'individual' : 'business');

        // Show success message
        CustomSnackbar.show(context, "Registration successful as ${isIndividual ? 'Individual' : 'Business'}", isError: false);
        
        // Navigate to the respective screen to complete additional information
        if (isIndividual) {
          Navigator.pushNamed(context, '/individualSignup'); // Navigate to Individual signup screen
        } else {
          Navigator.pushNamed(context, '/businessSignup'); // Navigate to Business signup screen
        }

        // Return user type
        return isIndividual ? UserType.individual : UserType.business;
      } else {
        CustomSnackbar.show(context, "Error: User registration failed", isError: true);
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication error
      CustomSnackbar.show(context, "Error during registration: ${e.message}", isError: true);
    } catch (e) {
      // Handle any other errors
      CustomSnackbar.show(context, "Error during registration: $e", isError: true);
    }

    return null;
  }
}
