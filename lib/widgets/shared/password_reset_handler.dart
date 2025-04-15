import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasswordResetHandler {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> verifyResetRequest(String email) async {
    try {
      final snapshot = await _firestore.collection('password_resets')
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .where('expiresAt', isGreaterThan: DateTime.now())
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> markRequestAsUsed(String email) async {
    await _firestore.collection('password_resets')
        .where('email', isEqualTo: email)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({'status': 'used'});
      }
    });
  }
}