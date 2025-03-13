import 'package:flutter/material.dart';

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
}