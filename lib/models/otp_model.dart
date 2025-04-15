import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class OtpModel {
  final TextEditingController otpController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _email;
  String? _generatedOtp;

  Future<void> sendOtpToEmail(String email) async {
    try {
      _email = email;
      _generatedOtp = _generateOtp();

      await _firestore.collection('otp_codes').add({
        'email': email,
        'otp': _generatedOtp,
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': DateTime.now().add(Duration(minutes: 5)),
        'status': 'pending'
      });

      await _sendEmailWithOtp(email, _generatedOtp!);
    } catch (e) {
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

  String _generateOtp() => (100000 + Random().nextInt(900000)).toString();

  Future<void> _sendEmailWithOtp(String email, String otp) async {
    debugPrint('Email sent to $email with OTP: $otp');
  }

  Future<void> verifyOtp() async {
    try {
      final enteredOtp = otpController.text.trim();
      final snapshot = await _firestore.collection('otp_codes')
          .where('email', isEqualTo: _email)
          .where('otp', isEqualTo: enteredOtp)
          .where('expiresAt', isGreaterThan: DateTime.now())
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('Invalid, expired or already used OTP');
      }

      await snapshot.docs.first.reference.update({'status': 'used'});
    } catch (e) {
      throw Exception('Verification failed: ${e.toString()}');
    }
  }

  void dispose() => otpController.dispose();
}
