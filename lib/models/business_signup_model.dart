import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
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

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('fullName', fullNameController.text);
    await prefs.setString('companyName', companyNameController.text);
    await prefs.setString('companyLocation', companyLocationController.text);
    await prefs.setString('budget', budgetController.text);
    await prefs.setString('numberOfEmployees', numberOfEmployeesController.text);

    await prefs.setString('userType', 'business'); 
    
    CustomSnackbar.show(context, 'Business registration successful!');
  }
}
