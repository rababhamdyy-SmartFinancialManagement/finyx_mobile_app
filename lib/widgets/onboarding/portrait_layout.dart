import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/onboarding/image_widget.dart';
import 'package:finyx_mobile_app/widgets/onboarding/text_widget.dart';
import 'package:finyx_mobile_app/models/onboarding_model.dart';

class OnboardingPortraitLayout extends StatelessWidget {
  final PageController pageController;
  final List<OnboardingPage> onboardingPages;
  final int currentPage;
  final Function(int) onPageChanged;

  const OnboardingPortraitLayout({
    super.key,
    required this.pageController,
    required this.onboardingPages,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: OnboardingImageWidget(
            pageController: pageController,
            images: onboardingPages.map((page) => page.image).toList(),
            onPageChanged: onPageChanged,
          ),
        ),
        Expanded(
          flex: 3,
          child: OnboardingTextWidget(
            currentPage: currentPage, 
            onboardingPages: onboardingPages,
          ),
        ),
      ],
    );
  }
}
