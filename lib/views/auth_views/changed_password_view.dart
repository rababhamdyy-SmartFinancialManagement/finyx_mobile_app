import 'package:flutter/material.dart';
import '../../models/password_changed_model.dart';
import 'package:finyx_mobile_app/widgets/buttons_widgets/button_widget.dart';
import 'package:finyx_mobile_app/widgets/greetings_widgets/greeting_widget.dart';

class PasswordChangedScreen extends StatelessWidget {
  PasswordChangedScreen({super.key});

  final PasswordChangedModel model = PasswordChangedModel();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/sucess.png",
              width: screenWidth * 0.7,
              height: screenHeight * 0.3,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.02),
            GreetingWidget(greetingText: "Password Changed", fontSize: 45),
            SizedBox(height: screenHeight * 0.01),
            Text(
              model.successMessage,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Color(0xB2575555),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: ButtonWidget(
                text: "Back to login",
                width: screenWidth * 0.7,
                height: screenHeight * 0.06,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
