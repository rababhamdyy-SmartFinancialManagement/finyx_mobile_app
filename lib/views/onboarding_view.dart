import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/onboarding_model.dart';
import 'package:finyx_mobile_app/widgets/button_widget.dart';
import 'package:finyx_mobile_app/widgets/greeting_message_widget.dart';
import 'package:finyx_mobile_app/widgets/greeting_widget.dart';
import 'package:finyx_mobile_app/widgets/indicator_widget.dart';
import 'package:finyx_mobile_app/widgets/register_text_widget.dart';
import 'package:finyx_mobile_app/widgets/skip_widget.dart';

class OnboardingScreen extends StatelessWidget {
  final int currentIndex;

  const OnboardingScreen({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final page = OnboardingPageModel.pages[currentIndex];
    final bool isLastPage =
        currentIndex == OnboardingPageModel.pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!isLastPage) const SkipWidget(),
            Image.asset(
              page.imageAsset,
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.4,
              fit: BoxFit.contain,
            ),
            GreetingWidget(greetingText: page.greetingText, fontSize: 30),
            GreetingMessageWidget(greetingMessage: page.messageText),
            Indicator(selectedIndex: page.indicatorIndex),
            const SizedBox(height: 20),
            ButtonWidget(
              text: page.buttonText,
              width: 198,
              height: 53,
              onPressed: () {
                if (!isLastPage) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OnboardingScreen(currentIndex: currentIndex + 1),
                    ),
                  );
                } else {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
            const RegisterText(),
          ],
        ),
      ),
    );
  }
}
