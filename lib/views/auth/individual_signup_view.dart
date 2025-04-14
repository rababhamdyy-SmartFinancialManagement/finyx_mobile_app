import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../models/individual_signup_model.dart';
import '../../widgets/auth_widgets/auth_options_widget.dart';
import '../../widgets/shared/button_widget.dart';
import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/splash/finyx_widget.dart';

class IndividualSignupView extends StatefulWidget {
  const IndividualSignupView({super.key});

  @override
  State<IndividualSignupView> createState() => _IndividualSignupViewState();
}

class _IndividualSignupViewState extends State<IndividualSignupView> {
  final IndividualSignupModel signupModel = IndividualSignupModel();

  @override
  void dispose() {
    signupModel.dispose();
    super.dispose();
  }

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
                  controller: signupModel.fullNameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Date of Birth",
                  hint: "DD/MM/YYYY",
                  controller: signupModel.dobController,
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Address",
                  hint: "Enter your address",
                  controller: signupModel.addressController,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Monthly Income",
                  hint: "Enter your monthly salary",
                  controller: signupModel.incomeController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "National ID",
                  hint: "Enter your national ID",
                  controller: signupModel.nationalIdController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.03),
                ButtonWidget(
                  text: "Sign Up",
                  onPressed: () async {
                    bool success = await signupModel.saveIndividualData(
                      context,
                    );
                    if (success) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/homepage',
                        arguments: UserType.individual,
                      );
                    }
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
