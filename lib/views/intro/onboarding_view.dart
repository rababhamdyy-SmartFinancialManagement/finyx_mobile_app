import 'package:finyx_mobile_app/widgets/intro/onboard_step_widget.dart';
import 'package:finyx_mobile_app/models/onboarding_model.dart';
import 'package:flutter/material.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < OnboardingPageModel.pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: OnboardingPageModel.pages.length,
                itemBuilder: (context, index) {
                  final page = OnboardingPageModel.pages[index];
                  final bool isLastPage = index == OnboardingPageModel.pages.length - 1;

                  return OnboardingStep(
                    page: page,
                    isLastPage: isLastPage,
                    onNext: _nextPage,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}