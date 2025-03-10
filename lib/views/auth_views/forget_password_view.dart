import 'package:finyx_mobile_app/widgets/buttons_widgets/button_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_background.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;
        final TextEditingController emailController = TextEditingController();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,

            leadingWidth: screenWidth * 0.15,
            leading: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                top: screenHeight * 0.0,
              ),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: screenWidth * 0.05,
                  ),
                ),
              ),
            ),
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
                      SizedBox(height: screenHeight * 0.08),
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontFamily: "Rockwell",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        "Don’t worry! It happens. Please enter the email associated with your account.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: "poppins",
                          fontSize: screenWidth * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Image.asset(
                        "assets/images/forget_pass.png",
                        width: screenWidth * 0.9,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      CustomTextField(
                        label: "Email address",
                        hint: "example123@gmail.com",
                        controller: emailController,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Center(
                        child: ButtonWidget(
                          text: "Send OTP",
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.06,
                          onPressed: () {},
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
