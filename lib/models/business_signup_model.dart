import 'package:flutter/material.dart';

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
}
