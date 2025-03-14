import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/onboarding_model.dart';
import 'package:finyx_mobile_app/widgets/shared/greeting_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/greeting_message_widget.dart';

/// Widget responsible for displaying the onboarding text content
class OnboardingTextWidget extends StatelessWidget {
  final int currentPage;
  final List<OnboardingPage> onboardingPages;

  const OnboardingTextWidget({
    super.key,
    required this.currentPage,
    required this.onboardingPages,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Column(
        key: ValueKey<int>(currentPage), // Ensures unique rebuild for each page
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GreetingWidget(greetingText: onboardingPages[currentPage].title),
          GreetingMessageWidget(greetingMessage: onboardingPages[currentPage].message),
        ],
      ),
    );
  }
}
