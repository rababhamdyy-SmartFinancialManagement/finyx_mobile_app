import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';

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
      if (user == null) return null;

      // إعادة تحميل بيانات المستخدم
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      // جلب أحدث بيانات من Firestore مع تعطيل الكاش
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(GetOptions(source: Source.server));

      if (!userDoc.exists) return null;

      // تحميل بيانات الملف الشخصي بقوة
      await context.read<ProfileCubit>().loadUserData();

      final userType = userDoc.data()?['userType'];
      final profileCubit = context.read<ProfileCubit>();

      // تحميل البيانات مع التأكد من تحديث الحالة
      await profileCubit.loadUserData();

      // حفظ بيانات الاعتماد إذا كان مطلوباً
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
        await context.read<PriceCubit>().loadFromFirestore();
        return UserType.individual;
      } else if (userType == "business") {
        await SharedPrefsHelper.saveUserType("business");
        await SharedPrefsHelper.saveLoginState(true);
        await context.read<PriceCubit>().loadFromFirestore();
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

  Future<Map<String, dynamic>?> signInWithGoogle(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user == null) return null;

      // الحصول على ProfileCubit من context
      final profileCubit = context.read<ProfileCubit>();
      profileCubit.resetState(); // إعادة تعيين الحالة
      await profileCubit.loadUserData(); // جلب بيانات المستخدم الجديد

      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(
            GetOptions(source: Source.server),
          ); // جلب أحدث البيانات من السيرفر
      if (userDoc.exists) {
        final userType = userDoc.get('userType');
        await _updateProfileData(user);
        await context.read<PriceCubit>().loadFromFirestore();
        return {
          'userType':
              userType == 'individual'
                  ? UserType.individual
                  : UserType.business,
          'isNewUser': false,
        };
      }

      // 🆕 مستخدم جديد - اختيار نوع المستخدم
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
        await GoogleSignIn().signOut();
        return null;
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'userType':
            selectedType == UserType.individual ? 'individual' : 'business',
        'email': user.email,
        'fullName': user.displayName ?? 'Google User',
        'photoUrl': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _updateProfileData(user);

      return {'userType': selectedType, 'isNewUser': true};
    } catch (e) {
      CustomSnackbar.show(
        context,
        "${loc.translate("google_sign_in_error")}: $e",
        isError: true,
      );
      return null;
    }
  }

  Future<void> _updateProfileData(User user) async {
    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    final userType = userDoc.get('userType') ?? 'individual';
    final collection = userType == 'individual' ? 'individuals' : 'businesses';

    await FirebaseFirestore.instance.collection(collection).doc(user.uid).set({
      'fullName': user.displayName ?? 'Google User',
      'profileImage': user.photoURL?.replaceAll('s96-c', 's400-c'),
      'email': user.email,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
