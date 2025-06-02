import 'package:finyx_mobile_app/widgets/onboarding/skip_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/register_text_widget.dart';
import 'package:finyx_mobile_app/widgets/onboarding/indicator_widget.dart';
import 'package:finyx_mobile_app/widgets/onboarding/action_button.dart';
import 'package:finyx_mobile_app/widgets/onboarding/landscape_layout.dart';
import 'package:finyx_mobile_app/widgets/onboarding/portrait_layout.dart';
import 'package:finyx_mobile_app/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _changePage(int newIndex) {
    _pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = onboardingPages(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Visibility(
              visible: _currentPage < pages.length - 1,
              child: const SkipWidget(),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isLandscape = constraints.maxWidth > constraints.maxHeight;
                  return isLandscape
                      ? OnboardingLandscapeLayout(
                    pageController: _pageController,
                    onboardingPages: pages,
                    currentPage: _currentPage,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                  )
                      : OnboardingPortraitLayout(
                    pageController: _pageController,
                    onboardingPages: pages,
                    currentPage: _currentPage,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                  );
                },
              ),
            ),
            OnboardingPageIndicator(
              controller: _pageController,
              pageCount: pages.length,
              onPageChange: _changePage,
            ),
            const SizedBox(height: 25),
            OnboardingActionButton(
              currentPage: _currentPage,
              totalPages: pages.length,
              onNextPressed: () {
                if (_currentPage < pages.length - 1) {
                  _changePage(_currentPage + 1);
                } else {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
            const SizedBox(height: 20),
            const RegisterText(),
          ],
        ),
      ),
    );
  }
}
