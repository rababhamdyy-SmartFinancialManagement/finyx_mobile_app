import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForgetPasswordModel {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPasswordResetEmail() async {
    try {
      final email = emailController.text.trim();

      await _auth.sendPasswordResetEmail(
        email: email,
        
        
      actionCodeSettings: ActionCodeSettings(
          url: 'https://finyxmobileapp.page.link/resetPassword',  
          handleCodeInApp: true,
          androidPackageName: 'com.example.finyx_mobile_app',  
          androidInstallApp: true,
          //iOSBundleId: 'com.example.finyxMobileApp',  
        ),
      
      );

      debugPrint("hereee");

      await _firestore.collection('password_resets').add({
        'email': email,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': DateTime.now().add(Duration(hours: 1)),
      });

 debugPrint("hereee222");

    } on FirebaseAuthException catch (e) {
      debugPrint("hereee333 :: ${e.message}");   
      debugPrint("hereee444 :: ${e.code}");

      await _logError(e.code);
      throw _mapErrorToMessage(e.code);
    }
  }

  Future<void> _logError(String errorCode) async {
    await _firestore.collection('password_reset_errors').add({
      'email': emailController.text.trim(),
      'error': errorCode,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  String _mapErrorToMessage(String code) {
    switch (code) {
      case 'invalid-email': return 'Invalid email address format';
      case 'user-not-found': return 'No user found with this email';
      default: return 'Failed to send reset link. Please try again.';
    }
  }

  void dispose() => emailController.dispose();
}
