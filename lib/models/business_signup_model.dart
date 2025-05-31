import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';

class BusinessSignUpModel {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyLocationController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController numberOfEmployeesController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void dispose() {
    companyNameController.dispose();
    companyLocationController.dispose();
    budgetController.dispose();
    numberOfEmployeesController.dispose();
    phoneNumberController.dispose();
  }

  bool areFieldsFilled() {
    return companyNameController.text.isNotEmpty &&
        companyLocationController.text.isNotEmpty &&
        budgetController.text.isNotEmpty &&
        numberOfEmployeesController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty;
  }

  bool validatePhoneNumber(String phone) {
    final phoneDigits = phone.replaceAll(RegExp(r'\D'), '');
    return phoneDigits.length == 10;
  }

  bool validateCompanyLocation(String address) {
    return address.trim().isNotEmpty && !RegExp(r'^\d+$').hasMatch(address);
  }

  bool validateCompanyName(String name) {
    return name.trim().isNotEmpty && !RegExp(r'^\d+$').hasMatch(name);
  }

  bool validateIncome(String income) {
    return RegExp(r'^\d+$').hasMatch(income);
  }

  bool validateNumberOfEmployees(String number) {
    return RegExp(r'^\d+$').hasMatch(number);
  }

  Future<bool> saveBusinessData(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    if (!areFieldsFilled()) {
      CustomSnackbar.show(
        context,
        loc.translate('pleaseFillAllFields'),
        isError: true,
      );
      return false;
    }

    if (!validatePhoneNumber(phoneNumberController.text)) {
      CustomSnackbar.show(
        context,
        loc.translate('invalidPhoneNumber'),
        isError: true,
      );
      return false;
    }

    if (!validateCompanyName(companyNameController.text)) {
      CustomSnackbar.show(
        context,
        loc.translate('invalidCompanyName'),
        isError: true,
      );
      return false;
    }

    if (!validateCompanyLocation(companyLocationController.text)) {
      CustomSnackbar.show(
        context,
        loc.translate('invalidCompanyLocation'),
        isError: true,
      );
      return false;
    }

    if (!validateIncome(budgetController.text)) {
      CustomSnackbar.show(
        context,
        loc.translate('invalidBudget'),
        isError: true,
      );
      return false;
    }

    if (!validateNumberOfEmployees(numberOfEmployeesController.text)) {
      CustomSnackbar.show(
        context,
        loc.translate('invalidNumberOfEmployees'),
        isError: true,
      );
      return false;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        CustomSnackbar.show(
          context,
          loc.translate('userNotAuthenticated'),
          isError: true,
        );
        return false;
      }

      await FirebaseFirestore.instance.collection('businesses').doc(user.uid).set({
        'phoneNumber': '+20${phoneNumberController.text}',
        'companyName': companyNameController.text,
        'companyLocation': companyLocationController.text,
        'budget': budgetController.text,
        'numberOfEmployees': numberOfEmployeesController.text,
        'userType': 'business',
      });

      CustomSnackbar.show(
        context,
        loc.translate('businessRegistrationSuccessful'),
      );
      return true;
    } catch (e) {
      CustomSnackbar.show(
        context,
        '${loc.translate('errorOccurred')}: $e',
        isError: true,
      );
      return false;
    }
  }
}
