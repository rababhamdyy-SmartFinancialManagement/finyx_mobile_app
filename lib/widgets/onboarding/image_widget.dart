import 'package:flutter/material.dart';

class OnboardingImageWidget extends StatelessWidget {
  final PageController pageController;
  final List<String> images;
  final Function(int) onPageChanged;

  const OnboardingImageWidget({
    super.key,
    required this.pageController,
    required this.images,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: images.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
