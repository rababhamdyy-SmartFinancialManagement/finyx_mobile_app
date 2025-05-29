import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';

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

  Future<void> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    final savedPassword = prefs.getString('saved_password');

    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      isChecked = true;
    }
  }

  Future<UserType?> loginUser(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.show(
        context,
        loc.translate("email_or_password_empty"),
        isError: true,
      );
      return null;
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user == null) {
        CustomSnackbar.show(
          context,
          loc.translate("login_failed_user_not_found"),
          isError: true,
        );
        return null;
      }

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      final userType = userDoc.data()?['userType'];

      final prefs = await SharedPreferences.getInstance();
      if (isChecked) {
        await prefs.setString('saved_email', email);
        await prefs.setString('saved_password', password);
      } else {
        await prefs.remove('saved_email');
        await prefs.remove('saved_password');
      }

      if (userType == "individual") {
        await SharedPrefsHelper.saveUserType("individual");
        await SharedPrefsHelper.saveLoginState(true);
        CustomSnackbar.show(
          context,
          loc.translate("logged_in_individual"),
          isError: false,
        );
        return UserType.individual;
      } else if (userType == "business") {
        await SharedPrefsHelper.saveUserType("business");
        await SharedPrefsHelper.saveLoginState(true);
        CustomSnackbar.show(
          context,
          loc.translate("logged_in_business"),
          isError: false,
        );
        return UserType.business;
      } else {
        CustomSnackbar.show(
          context,
          loc.translate("unknown_user_type"),
          isError: true,
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show(
        context,
        "${loc.translate("login_error")}: ${e.message}",
        isError: true,
      );
    } catch (e) {
      CustomSnackbar.show(
        context,
        "${loc.translate("unexpected_error")}: $e",
        isError: true,
      );
    }

    return null;
  }

  Future<UserType?> signInWithGoogle(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    try {
      print("📌 Starting Google Sign-In");

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("❌ googleUser is null");
        CustomSnackbar.show(
          context,
          loc.translate("google_sign_in_cancelled"),
          isError: true,
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null) {
        CustomSnackbar.show(
          context,
          loc.translate("google_sign_in_failed"),
          isError: true,
        );
        return null;
      }

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        // المستخدم موجود بالفعل → انتقل للـ home حسب نوع المستخدم المحفوظ
        final userType = userDoc.data()?['userType'];

        await SharedPrefsHelper.saveLoginState(true);
        await SharedPrefsHelper.saveUserType(userType);

        if (userType == "individual") {
          CustomSnackbar.show(
            context,
            loc.translate("logged_in_google_individual"),
            isError: false,
          );
          return UserType.individual;
        } else if (userType == "business") {
          CustomSnackbar.show(
            context,
            loc.translate("logged_in_google_business"),
            isError: false,
          );
          return UserType.business;
        } else {
          CustomSnackbar.show(
            context,
            loc.translate("unknown_user_type"),
            isError: true,
          );
          return null;
        }
      } else {
        // المستخدم جديد → أظهر حوار لاختيار نوع المستخدم
        String? selectedUserType = await showDialog<String>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(loc.translate("select_user_type")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed:
                        () => Navigator.of(dialogContext).pop("individual"),
                    child: Text(loc.translate("individual")),
                  ),
                  ElevatedButton(
                    onPressed:
                        () => Navigator.of(dialogContext).pop("business"),
                    child: Text(loc.translate("business")),
                  ),
                ],
              ),
            );
          },
        );

        if (selectedUserType == null) {
          CustomSnackbar.show(
            context,
            loc.translate("user_type_not_selected"),
            isError: true,
          );
          return null;
        }

        // حفظ البيانات لأول مرة
        await userRef.set({
          'userType': selectedUserType,
          'name': user.displayName ?? googleUser.displayName ?? '',
          'email': user.email ?? googleUser.email ?? '',
          'photoURL': user.photoURL ?? googleUser.photoUrl ?? '',
        }, SetOptions(merge: true));

        await SharedPrefsHelper.saveLoginState(true);
        await SharedPrefsHelper.saveUserType(selectedUserType);

        if (selectedUserType == "individual") {
          CustomSnackbar.show(
            context,
            loc.translate("logged_in_google_individual"),
            isError: false,
          );
          return UserType.individual;
        } else {
          CustomSnackbar.show(
            context,
            loc.translate("logged_in_google_business"),
            isError: false,
          );
          return UserType.business;
        }
      }
    } catch (e) {
      print("❌ Exception during Google sign in: $e");
      CustomSnackbar.show(
        context,
        "${loc.translate("google_sign_in_error")}: $e",
        isError: true,
      );
      return null;
    }
  }
}
