import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessSignUpModel {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyLocationController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController numberOfEmployeesController = TextEditingController();

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

  Future<void> saveBusinessData(BuildContext context) async {
    if (!areFieldsFilled()) {
      CustomSnackbar.show(context, 'Please fill all the fields!', isError: true);
      return; 
    }

    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final userRef = firestore.collection('businesses').doc();  

      // Add data to Firestore
      await userRef.set({
        'fullName': fullNameController.text,
        'companyName': companyNameController.text,
        'companyLocation': companyLocationController.text,
        'budget': budgetController.text,
        'numberOfEmployees': numberOfEmployeesController.text,
        'userType': 'business', 
      });

      // Check if the document exists
      DocumentSnapshot documentSnapshot = await userRef.get();
      if (documentSnapshot.exists) {
        print('Document exists: ${documentSnapshot.data()}');
        CustomSnackbar.show(context, 'Business registration successful!');
      } else {
        print('No document found');
        CustomSnackbar.show(context, 'Failed to save data', isError: true);
      }

      // Save userType to SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userType', 'business'); 

    } catch (e) {
      CustomSnackbar.show(context, 'Error occurred: $e', isError: true);
    }
  }
}
