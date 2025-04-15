import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResetPasswordModel {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updatePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      throw Exception('Passwords do not match');
    }

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');
      
      await user.updatePassword(newPasswordController.text.trim());
      await _logPasswordReset(user.uid, user.email!);
    } catch (e) {
      await _logPasswordResetError(e.toString());
      throw Exception('Password update failed: ${e.toString()}');
    }
  }

  Future<void> _logPasswordReset(String userId, String email) async {
    await _firestore.collection('password_resets').add({
      'userId': userId,
      'email': email,
      'status': 'completed',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _logPasswordResetError(String error) async {
    await _firestore.collection('password_reset_errors').add({
      'error': error,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}