import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
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
  final TextEditingController fullNameController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
  }

  bool validatePassword(String password) {
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);
    return hasUppercase && hasLowercase && hasDigit && password.length >= 6;
  }

  Future<UserType?> registerUser(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final fullName = fullNameController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        fullName.isEmpty) {
      CustomSnackbar.show(
        context,
        loc.translate("allFieldsRequired"),
        isError: true,
      );
      return null;
    }

    if (fullName.length > 20) {
      CustomSnackbar.show(
        context,
        loc.translate("fullNameTooLong"),
        isError: true,
      );
      return null;
    }

    final containsNumber = RegExp(r'\d').hasMatch(fullName);
    if (containsNumber) {
      CustomSnackbar.show(
        context,
        loc.translate("fullNameNoNumbers"),
        isError: true,
      );
      return null;
    }

    if (password != confirmPassword) {
      CustomSnackbar.show(
        context,
        loc.translate("passwordsNotMatch"),
        isError: true,
      );
      return null;
    }

    if (!validatePassword(password)) {
      CustomSnackbar.show(
        context,
        loc.translate(
          "passwordRequirements",
        ), // لازم تضيفي النص ده في ملف اللغات
        isError: true,
      );
      return null;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        final userType = isIndividual ? 'individual' : 'business';

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'userType': userType,
        });

        await SharedPrefsHelper.saveUserType(userType);

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
          loc.translate("userRegistrationFailed"),
          isError: true,
        );
      }
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show(
        context,
        "${loc.translate("registrationError")}: ${e.message}",
        isError: true,
      );
    } catch (e) {
      CustomSnackbar.show(
        context,
        "${loc.translate("registrationError")}: $e",
        isError: true,
      );
    }

    return null;
  }
}
