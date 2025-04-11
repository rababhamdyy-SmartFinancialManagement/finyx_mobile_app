import 'package:flutter/material.dart';
import '../../models/forget_password_model.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_background.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_textfield_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import '../../widgets/custom_widgets/custom_appbar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

  @override
  void dispose() {
    forgetPasswordModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          body: Stack(
            children: [
              const CustomBackground(),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.001,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTitleSection(
                        title: "Forgot Password",
                        subtitle:
                        "Don’t worry! It happens. Please enter the email associated with your account.",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Image.asset(
                        "assets/images/otp/forget_pass.png",
                        width: screenWidth * 0.9,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      CustomTextField(
                        label: "Email address",
                        hint: "example123@gmail.com",
                        controller: forgetPasswordModel.emailController,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Center(
                        child: ButtonWidget(
                          text: "Send OTP",
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.06,
                          onPressed: () {
                            Navigator.pushNamed(context, '/otp_view');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
