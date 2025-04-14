import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndividualSignupModel {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();

  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    addressController.dispose();
    incomeController.dispose();
    nationalIdController.dispose();
  }

  bool areFieldsFilled() {
    return fullNameController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        incomeController.text.isNotEmpty &&
        nationalIdController.text.isNotEmpty;
  }

  Future<void> saveIndividualData(BuildContext context) async {
    if (!areFieldsFilled()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all the fields!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not authenticated'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('individuals')
          .doc(user.uid)
          .set({
            'fullName': fullNameController.text,
            'dob': dobController.text,
            'address': addressController.text,
            'income': incomeController.text,
            'nationalId': nationalIdController.text,
            'userType': 'individual',
          });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Individual registration successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
