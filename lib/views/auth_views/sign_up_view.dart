import 'package:finyx_mobile_app/widgets/auth_widgets/auth_options_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/buttons_widgets/button_widget.dart';
import '../../widgets/custom_widgets/finyx_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool isIndividual = true;
  final TextEditingController emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
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
                  isSelected: [isIndividual, !isIndividual],
                  onPressed: (index) {
                    setState(() {
                      isIndividual = index == 0;
                    });
                  },
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.37,
                    minHeight: MediaQuery.of(context).size.height * 0.05,
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Text("Individual", style: TextStyle()),
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Password",
                  hint: "Enter your password",
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Confirm Password",
                  hint: "Enter your password",
                  controller: confirmPasswordController,
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: "Phone Number",
                  hint: "Enter your phone number",
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.03),
                ButtonWidget(
                  text: "Sign Up",
                  onPressed:
                      isIndividual
                          ? () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/individual_signup',
                            );
                          }
                          : () {
                            Navigator.pushReplacementNamed(context, '/business_signup');
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
