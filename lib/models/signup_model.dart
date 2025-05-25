import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpModel {
  bool isIndividual = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
  }

  Future<UserType?> registerUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final phoneNumber = phoneNumberController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phoneNumber.isEmpty) {
      CustomSnackbar.show(context, "All fields must be filled", isError: true);
      return null;
    }

    if (password != confirmPassword) {
      CustomSnackbar.show(context, "Passwords do not match", isError: true);
      return null;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        final userType = isIndividual ? 'individual' : 'business';

        // Save basic user info in 'users' collection
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'phoneNumber': phoneNumber,
          'userType': userType,
        });

        // Save userType in SharedPreferences
        await SharedPrefsHelper.saveUserType(userType);

        // Navigate to the respective signup page
        if (isIndividual) {
          Navigator.pushNamed(
            context,
            '/individual_signup',
            arguments: user.uid,
          );
        } else {
          Navigator.pushNamed(context, '/business_signup', arguments: user.uid);
        }

        return isIndividual ? UserType.individual : UserType.business;
      } else {
        CustomSnackbar.show(
          context,
          "Error: User registration failed",
          isError: true,
        );
      }
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show(
        context,
        "Error during registration: ${e.message}",
        isError: true,
      );
    } catch (e) {
      CustomSnackbar.show(
        context,
        "Error during registration: $e",
        isError: true,
      );
    }

    return null;
  }
}
