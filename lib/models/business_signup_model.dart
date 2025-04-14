import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessSignUpModel {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyLocationController =
      TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController numberOfEmployeesController =
      TextEditingController();

  void dispose() {
    fullNameController.dispose();
    companyNameController.dispose();
    companyLocationController.dispose();
    budgetController.dispose();
    numberOfEmployeesController.dispose();
  }

  bool areFieldsFilled() {
    return fullNameController.text.isNotEmpty &&
        companyNameController.text.isNotEmpty &&
        companyLocationController.text.isNotEmpty &&
        budgetController.text.isNotEmpty &&
        numberOfEmployeesController.text.isNotEmpty;
  }

  Future<bool> saveBusinessData(BuildContext context) async {
    if (!areFieldsFilled()) {
      CustomSnackbar.show(
        context,
        'Please fill all the fields!',
        isError: true,
      );
      return false;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        CustomSnackbar.show(context, 'User not authenticated', isError: true);
        return false;
      }

      await FirebaseFirestore.instance
          .collection('businesses')
          .doc(user.uid)
          .set({
            'fullName': fullNameController.text,
            'companyName': companyNameController.text,
            'companyLocation': companyLocationController.text,
            'budget': budgetController.text,
            'numberOfEmployees': numberOfEmployeesController.text,
            'userType': 'business',
          });

      CustomSnackbar.show(context, 'Business registration successful!');
      return true;
    } catch (e) {
      CustomSnackbar.show(context, 'Error occurred: $e', isError: true);
      return false;
    }
  }
}
