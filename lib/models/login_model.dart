import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';

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

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.show(context, "Email or password cannot be empty", isError: true);
      return null;
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user == null) {
        CustomSnackbar.show(context, "Login failed. User not found.", isError: true);
        return null;
      }

      // جلب نوع المستخدم من Firestore
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userSnapshot = await userRef.get();
      final userType = userSnapshot.data()?['userType']; // ✅ تم التعديل هنا

      if (userType == "individual") {
        await SharedPrefsHelper.saveUserType("individual");
        CustomSnackbar.show(context, "Logged in as Individual", isError: false);

        if (isChecked) {
          CustomSnackbar.show(context, "You will be remembered!", isError: false);
        }

        return UserType.individual;

      } else if (userType == "business") {
        await SharedPrefsHelper.saveUserType("business");
        CustomSnackbar.show(context, "Logged in as Business", isError: false);

        if (isChecked) {
          CustomSnackbar.show(context, "You will be remembered!", isError: false);
        }

        return UserType.business;
      } else {
        CustomSnackbar.show(context, "Unknown user type", isError: true);
        return null;
      }
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show(context, "Login error: ${e.message}", isError: true);
    } catch (e) {
      CustomSnackbar.show(context, "Unexpected error: $e", isError: true);
    }

    return null;
  }

  Future<UserType?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        CustomSnackbar.show(context, "Google sign-in cancelled", isError: true);
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        CustomSnackbar.show(context, "Google sign-in failed", isError: true);
        return null;
      }

      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userSnapshot = await userRef.get();
      final userType = userSnapshot.data()?['userType'];

      if (userType == "individual") {
        await SharedPrefsHelper.saveUserType("individual");
        CustomSnackbar.show(context, "Logged in with Google (Individual)", isError: false);
        return UserType.individual;
      } else if (userType == "business") {
        await SharedPrefsHelper.saveUserType("business");
        CustomSnackbar.show(context, "Logged in with Google (Business)", isError: false);
        return UserType.business;
      } else {
        CustomSnackbar.show(context, "Unknown user type", isError: true);
        return null;
      }
    } catch (e) {
      CustomSnackbar.show(context, "Google sign-in error: $e", isError: true);
      return null;
    }
  }
}
