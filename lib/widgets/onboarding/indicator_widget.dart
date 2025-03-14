import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final PageController controller;
  final int pageCount;
  final Function(int) onPageChange;

  const OnboardingPageIndicator({
    super.key,
    required this.controller,
    required this.pageCount,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: pageCount,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: const Color(0xFF3E0555),
        dotColor: Colors.grey.shade400,
      ),
      onDotClicked: onPageChange,
    );
  }
}
