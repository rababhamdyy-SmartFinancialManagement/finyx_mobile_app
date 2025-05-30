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
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
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
      final userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        final userType = userSnapshot.data()?['userType'];

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
      }

      // Dialog to choose userType
      UserType? selectedType = await showDialog<UserType>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Colors.grey, width: 3),
                ),
                title: Text(
                  loc.translate("select_user_type"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed:
                            () => Navigator.pop(context, UserType.individual),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF3E0555),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          loc.translate("individual"),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed:
                            () => Navigator.pop(context, UserType.business),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF3E0555),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          loc.translate("business"),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFBBC05),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        loc.translate("cancel"),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (selectedType == null) {
        CustomSnackbar.show(
          context,
          loc.translate("user_type_not_selected"),
          isError: true,
        );
        await GoogleSignIn().signOut();
        return null;
      }

      final userData = {
        "userType":
            selectedType == UserType.individual ? "individual" : "business",
        "email": user.email,
        "name": user.displayName,
        "photoUrl": user.photoURL,
        "createdAt": FieldValue.serverTimestamp(),
      };

      await userRef.set(userData);

      final userTypeString = userData["userType"] as String;

      await SharedPrefsHelper.saveUserType(userTypeString);
      await SharedPrefsHelper.saveLoginState(true);

      CustomSnackbar.show(
        context,
        loc.translate("account_created_successfully"),
        isError: false,
      );

      return selectedType;
    } catch (e) {
      CustomSnackbar.show(
        context,
        "${loc.translate("google_sign_in_error")}: $e",
        isError: true,
      );
      return null;
    }
  }
}
