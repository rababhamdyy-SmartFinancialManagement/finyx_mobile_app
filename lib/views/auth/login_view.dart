import 'package:finyx_mobile_app/models/PasswordPageType.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/auth/forget_password_view.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../models/login_model.dart';
import '../../widgets/auth_widgets/auth_options_widget.dart';
import '../../widgets/shared/button_widget.dart';
import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/splash/finyx_widget.dart';
import '../../cubits/wallet/shared_pref_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginModel loginModel = LoginModel();

  @override
  void initState() {
    super.initState();
    loginModel.loadSavedCredentials().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    loginModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
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
                  label: loc.translate("email"),
                  hint: loc.translate("enter_email"),
                  controller: loginModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                  label: loc.translate("password"),
                  hint: loc.translate("enter_password"),
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
                          activeColor: const Color(0xFFDA9220),
                        ),
                        Text(
                          loc.translate("remember_me"),
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ForgetPasswordView(
                                  pageType: PasswordPageType.forget,
                                ),
                          ),
                        );
                      },
                      child: Text(loc.translate("forget_password")),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.06),
                ButtonWidget(
                  text: loc.translate("login"),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                  onPressed: () async {
                    final result = await loginModel.loginUser(context);
                    if (result != null) {
                      final userType = await SharedPrefsHelper.getUserType();
                      if (userType != null) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/homepage',
                          arguments:
                              userType == 'individual'
                                  ? UserType.individual
                                  : UserType.business,
                        );
                      } else {
                        CustomSnackbar.show(
                          context,
                          loc.translate("unknown_user_type"),
                          isError: true,
                        );
                      }
                    } else {
                      CustomSnackbar.show(
                        context,
                        loc.translate("login_failed"),
                        isError: true,
                      );
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
