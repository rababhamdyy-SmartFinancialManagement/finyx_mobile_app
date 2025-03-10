import 'package:flutter/material.dart';

import '../../widgets/auth_widgets/auth_options_widget.dart';
import '../../widgets/buttons_widgets/button_widget.dart';
import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/custom_widgets/finyx_widget.dart';

class IndividualSignupView extends StatefulWidget {
  const IndividualSignupView({super.key});

  @override
  State<IndividualSignupView> createState() => _IndividualSignupViewState();
}

class _IndividualSignupViewState extends State<IndividualSignupView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.01),
                FinyxWidget(fontSize: screenWidth * 0.14),
                SizedBox(height: screenHeight * 0.04),
                CustomTextField(
                  label: "Full Name",
                  hint: "Enter your full name",
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Date of Birth",
                  hint: "DD/MM/YYYY",
                  controller: dobController,
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Address",
                  hint: "Enter your address",
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Monthly Income",
                  hint: "Enter your monthly salary",
                  controller: incomeController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "National ID",
                  hint: "Enter your national ID",
                  controller: nationalIdController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.03),
                ButtonWidget(
                  text: "Sign Up",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.06,
                ),
                SizedBox(height: screenHeight * 0.04),
                SocialAuthButtons(isSignup: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
