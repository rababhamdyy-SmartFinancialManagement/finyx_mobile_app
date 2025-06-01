import 'package:flutter/material.dart';
import 'applocalization.dart';

class OnboardingPage {
  final String image;
  final String title;
  final String message;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.message,
  });
}

List<OnboardingPage> onboardingPages(BuildContext context) {
  final loc = AppLocalizations.of(context)!;

  return [
    OnboardingPage(
      image: "assets/images/intro/financial_planning_1.png",
      title: loc.translate("onboarding_title_1"),
      message: loc.translate("onboarding_msg_1"),
    ),
    OnboardingPage(
      image: "assets/images/intro/report_1.png",
      title: loc.translate("onboarding_title_2"),
      message: loc.translate("onboarding_msg_2"),
    ),
    OnboardingPage(
      image: "assets/images/intro/planning_1.png",
      title: loc.translate("onboarding_title_3"),
      message: loc.translate("onboarding_msg_3"),
    ),
  ];
}
