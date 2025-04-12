import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../models/login_model.dart';
import '../../widgets/auth_widgets/auth_options_widget.dart';
import '../../widgets/shared/button_widget.dart';
import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/splash/finyx_widget.dart';
import '../../cubits/wallet/shared_pref_helper.dart';
//import '../../models/user_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginModel loginModel = LoginModel();

  @override
  void dispose() {
    loginModel.dispose();
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
                SizedBox(height: screenHeight * 0.06),
                FinyxWidget(fontSize: screenWidth * 0.14),
                SizedBox(height: screenHeight * 0.1),
                CustomTextField(
                  label: "Email",
                  hint: "Enter your email",
                  controller: loginModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                  label: "Password",
                  hint: "Enter your password",
                  controller: loginModel.passwordController,
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.001),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: loginModel.isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              loginModel.toggleRememberMe(value);
                            });
                          },
                          activeColor: const Color(0xFF3E0555),
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forget_password');
                      },
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.06),
                ButtonWidget(
                  text: "Login",
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                  onPressed: () async {
                    // Handle login
                    final result = await loginModel.loginUser(context);
                    if (result != null) {
                      final userType = await SharedPrefsHelper.getUserType();
                      print(userType); 
                      if (userType != null) {
                        Navigator.pushReplacementNamed(context, '/homepage', arguments: userType);
                      } else {
                        CustomSnackbar.show(context, 'Unknown user type', isError: true);
                      }
                    } else {
                      CustomSnackbar.show(context, 'Login failed, please try again', isError: true);
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
                SocialAuthButtons(isSignup: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
