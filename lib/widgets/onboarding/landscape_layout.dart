import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/onboarding/image_widget.dart';
import 'package:finyx_mobile_app/widgets/onboarding/text_widget.dart';
import 'package:finyx_mobile_app/models/onboarding_model.dart';

class OnboardingLandscapeLayout extends StatelessWidget {
  final PageController pageController;
  final List<OnboardingPage> onboardingPages;
  final Function(int) onPageChanged;
  final int currentPage; 

  const OnboardingLandscapeLayout({
    super.key,
    required this.pageController,
    required this.onboardingPages,
    required this.onPageChanged,
    required this.currentPage, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OnboardingImageWidget(
            pageController: pageController,
            images: onboardingPages.map((page) => page.image).toList(),
            onPageChanged: onPageChanged,
          ),
        ),
        const SizedBox(width: 20),
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
