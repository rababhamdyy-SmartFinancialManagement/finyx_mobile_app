import 'package:finyx_mobile_app/widgets/shared/curved_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/reset_password_model.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_textfield_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;
        final ResetPasswordModel resetPasswordModel = ResetPasswordModel();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          body: Stack(
            children: [
            CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: CurvedBackgroundPainter(context),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.08,
                      top: screenHeight * 0.01,
                    ),
                    child: CustomTitleSection(
                      title: "Reset Password",
                      subtitle: "Please type something you’ll remember",
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: "New password",
                              hint: "must be 8 characters",
                              controller: resetPasswordModel.passwordController,
                              obscureText: true,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextField(
                              label: "Confirm new password",
                              hint: "repeat password",
                              controller: resetPasswordModel.passwordController,
                              obscureText: true,
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            Center(
                              child: ButtonWidget(
                                text: "Reset password",
                                width: screenWidth * 0.7,
                                height: screenHeight * 0.06,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/password_changed_view');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
