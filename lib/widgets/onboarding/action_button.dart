import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';

class OnboardingActionButton extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPressed;

  const OnboardingActionButton({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      text: currentPage < totalPages - 1 ? "Next" : "Get Started",
      width: 198,
      height: 53,
      onPressed: onNextPressed,
    );
  }
}
