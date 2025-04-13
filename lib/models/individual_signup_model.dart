import 'package:cloud_firestore/cloud_firestore.dart';
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
        SnackBar(content: Text('Please fill all the fields!'), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      final CollectionReference individuals = FirebaseFirestore.instance.collection('individuals');
      final docRef = await individuals.add({
        'fullName': fullNameController.text,
        'dob': dobController.text,
        'address': addressController.text,
        'income': incomeController.text,
        'nationalId': nationalIdController.text,
        'userType': 'individual',
      });

      // Check if the document was successfully added
      DocumentSnapshot documentSnapshot = await individuals.doc(docRef.id).get();

      if (documentSnapshot.exists) {
        print('Document exists: ${documentSnapshot.data()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Individual registration successful!')),
        );
      } else {
        print('No document found');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data'), backgroundColor: Colors.red),
        );
      }

      // Save userType to SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userType', 'individual'); 
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
