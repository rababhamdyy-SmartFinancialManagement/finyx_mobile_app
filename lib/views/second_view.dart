import 'package:finyx_mobile_app/widgets/buttons_widgets/button_widget.dart';
import 'package:finyx_mobile_app/widgets/greetings_widgets/greeting_message_widget.dart';
import 'package:finyx_mobile_app/widgets/greetings_widgets/greeting_widget.dart';
import 'package:finyx_mobile_app/widgets/indicators_widgets/indicator_widget.dart';
import 'package:finyx_mobile_app/widgets/buttons_widgets/skip_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_widgets/auth_footer_text_widget.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkipWidget(),
            Image.asset(
              "assets/images/report_1.png",
              width: screenWidth * 0.8,
              height: screenHeight * 0.4,
              fit: BoxFit.contain,
            ),
            GreetingWidget(greetingText: "Plan your finances", fontSize: 30),
            GreetingMessageWidget(
              greetingMessage:
                  "track your progress, and achieve your financial goals with confidence",
            ),
            Indicator(selectedIndex: 1),
            SizedBox(height: 20),
            ButtonWidget(
              text: "Next",
              width: 165,
              height: 53,
              onPressed: () {
                Navigator.pushNamed(context, '/thirdScreen');
              },
            ),
            AuthFooterText(isSignup: false, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}
