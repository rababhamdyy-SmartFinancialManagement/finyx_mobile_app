import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/CustomTextField_widget.dart';
import 'package:finyx_mobile_app/widgets/button_widget.dart';
import 'package:finyx_mobile_app/widgets/finyx_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                SizedBox(height: screenHeight * 0.04),
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
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFF2F80ED),
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forget_password');
                      },
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(
                          color: Color(0xFF2F80ED),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                ButtonWidget(
                  text: "Login",
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                  onPressed: () {
                   Navigator.pushNamed(context, '/home');
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
