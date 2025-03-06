import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/greeting_widget.dart';
import 'package:finyx_mobile_app/widgets/greeting_message_widget.dart';
import 'package:finyx_mobile_app/widgets/skip_widget.dart';
import 'package:finyx_mobile_app/widgets/indicator_widget.dart';
import 'package:finyx_mobile_app/widgets/button_widget.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkipWidget(),
            Image.asset(
              "assets/images/financial_planning_1.png",
              fit: BoxFit.cover,
            ),
            GreetingWidget(greetingText: "Welcome to Finyx!", fontSize: 24),
            GreetingMessageWidget(
              greetingMessage:
                  "Take control of your finances effortlessly track, save, and grow with ease",
            ),
            Indicator(selectedIndex: 0),
            SizedBox(height: 20),
            ButtonWidget(text: "Next", size: Size(165, 53)),
          ],
        ),
      ),
    );
  }
}
