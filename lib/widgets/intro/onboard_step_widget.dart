import 'package:finyx_mobile_app/models/onboarding_model.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/greeting_message_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/greeting_widget.dart';
import 'package:finyx_mobile_app/widgets/intro/indicator_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/register_text_widget.dart';
import 'package:finyx_mobile_app/widgets/intro/skip_widget.dart';
import 'package:flutter/material.dart';

class OnboardingStep extends StatelessWidget {
  final OnboardingPageModel page;
  final bool isLastPage;
  final VoidCallback onNext;

  const OnboardingStep({
    required this.page,
    required this.isLastPage,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Column(
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
          onPressed: onNext,
        ),
        const RegisterText(),
      ],
    );
  }
}
