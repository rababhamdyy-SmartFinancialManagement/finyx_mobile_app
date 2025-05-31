import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class IndividualSignupModel {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();

  void dispose() {
    phoneNumberController.dispose();
    dobController.dispose();
    addressController.dispose();
    incomeController.dispose();
    nationalIdController.dispose();
  }

  bool areFieldsFilled() {
    return phoneNumberController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        incomeController.text.isNotEmpty &&
        nationalIdController.text.isNotEmpty;
  }

  bool validatePhoneNumber(String phone) {
    final phoneDigits = phone.replaceAll(RegExp(r'\D'), '');
    return phoneDigits.length == 10;
  }

  bool validateNationalId(String id) {
    return RegExp(r'^\d{14}$').hasMatch(id);
  }

  bool validateDOB(String dob) {
    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(dob);
      final now = DateTime.now();
      final age =
          now.year -
          date.year -
          ((now.month < date.month ||
                  (now.month == date.month && now.day < date.day))
              ? 1
              : 0);
      return age >= 0 && age <= 120;
    } catch (e) {
      return false;
    }
  }

  bool validateAddress(String address) {
    return address.trim().isNotEmpty && !RegExp(r'^\d+$').hasMatch(address);
  }

  bool validateIncome(String income) {
    return RegExp(r'^\d+$').hasMatch(income);
  }

  Future<void> pickDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<bool> saveIndividualData(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    if (!areFieldsFilled()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.translate("fillAllFields")),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (!validatePhoneNumber(phoneNumberController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.translate("invalidPhoneNumber")),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (!validateNationalId(nationalIdController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.translate("invalidNationalId")),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (!validateDOB(dobController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.translate("invalidDOB")),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (!validateAddress(addressController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.translate("invalidAddress")),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (!validateIncome(incomeController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.translate("invalidIncome")),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.translate("userNotAuthenticated")),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }

      await FirebaseFirestore.instance
          .collection('individuals')
          .doc(user.uid)
          .set({
            'dob': dobController.text,
            'address': addressController.text,
            'income': incomeController.text,
            'nationalId': nationalIdController.text,
            'phoneNumber': '+20${phoneNumberController.text}',
            'userType': 'individual',
          });

      CustomSnackbar.show(
        context,
        loc.translate("individualRegistrationSuccess"),
      );
      return true;
    } catch (e) {
      CustomSnackbar.show(
        context,
        '${loc.translate("errorOccurred")}: $e',
        isError: true,
      );
      return false;
    }
  }
}
