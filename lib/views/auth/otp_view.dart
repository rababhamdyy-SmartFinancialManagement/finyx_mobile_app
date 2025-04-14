import 'package:finyx_mobile_app/widgets/shared/curved_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/auth_widgets/otp_widget.dart';
import 'package:finyx_mobile_app/widgets/auth_widgets/resend_otp_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_background.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;
        // final OtpModel otpModel = OtpModel();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            iconColor: Colors.white,
            backgroundColor: Color(0xFFFFFFFF),
          ),
          body: Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 300),
                painter: CurvedBackgroundPainter(context),
              ),
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
                        title: "OTP Verification",
                        subtitle:
                            "Enter the verification code sent to your email to complete login securely.",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        titleColor: Colors.white, // تحديد اللون الأبيض للعنوان
                        subtitleColor: Colors.white.withValues(alpha: 0.7),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Image.asset(
                        "assets/images/otp/otp.png",
                        width: screenWidth * 0.9,
                      ),
                      Text(
                        "We will send you a one-time password to this email address.",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          color: Color(0xB2575555),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      OtpWidget(),
                      ResendOtp(),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: ButtonWidget(
                          text: "Send OTP",
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.06,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/reset_password_view',
                            );
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
