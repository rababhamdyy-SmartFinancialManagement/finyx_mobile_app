import 'package:flutter/material.dart';
import '../widgets/CustomTextField_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/finyx_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool isIndividual = true;
  final TextEditingController emailController = TextEditingController();
  final  passwordController = TextEditingController();
  final  confirmPasswordController = TextEditingController();
  final  phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
                SizedBox(height: screenHeight * 0.07),
                FinyxWidget(fontSize: screenWidth * 0.1),

                // ToggleButtons بين Individual و Business
                SizedBox(height: screenHeight * 0.02),
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text("Individual",style: TextStyle(),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text("Business"),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),

                // حقول الإدخال
                CustomTextField(
                  label: "Email",
                  hint: "Enter your email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  label: "Password",
                  hint: "Enter your password",
                  controller: passwordController,
                  obscureText: true,
                ),
                CustomTextField(
                  label: "Confirm Password",
                  hint: "Enter your password",
                  controller: confirmPasswordController,
                  obscureText: true,
                ),
                CustomTextField(
                  label: "Phone Number",
                  hint: "Enter your phone number",
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.02),

               
                ButtonWidget(
                  text: "Sign Up",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                ),
                SizedBox(height: screenHeight * 0.02),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
