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
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('fullName', fullNameController.text);
    await prefs.setString('dob', dobController.text);
    await prefs.setString('address', addressController.text);
    await prefs.setString('income', incomeController.text);
    await prefs.setString('nationalId', nationalIdController.text);

    await prefs.setString('userType', 'individual'); 
  }
}
