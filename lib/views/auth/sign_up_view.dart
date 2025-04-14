import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/signup_model.dart';
import 'package:finyx_mobile_app/widgets/auth_widgets/auth_options_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_textfield_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/widgets/splash/finyx_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final SignUpModel signUpModel = SignUpModel();

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
                ToggleButtons(
                  borderRadius: BorderRadius.circular(20),
                  selectedColor: Colors.white,
                  fillColor: const Color(0xFF4B136F),
                  color: Colors.grey,
                  isSelected: [
                    signUpModel.isIndividual,
                    !signUpModel.isIndividual,
                  ],
                  onPressed: (index) {
                    setState(() {
                      signUpModel.isIndividual = index == 0;
                    });
                  },
                  constraints: BoxConstraints(
                    minWidth: screenWidth * 0.37,
                    minHeight: screenHeight * 0.05,
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Text("Individual"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Text("Business"),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomTextField(
                  label: "Email",
                  hint: "Enter your email",
                  controller: signUpModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Password",
                  hint: "Enter your password",
                  controller: signUpModel.passwordController,
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Confirm Password",
                  hint: "Enter your password",
                  controller: signUpModel.confirmPasswordController,
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Phone Number",
                  hint: "Enter your phone number",
                  controller: signUpModel.phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.03),
                ButtonWidget(
                  text: "Sign Up",
                  onPressed: () async {
                    final result = await signUpModel.registerUser(context);
                    if (result == null) {
                      // Error handling is already done in registerUser
                      return;
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
