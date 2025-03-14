/// Model: Represents a single onboarding page
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

/// List of onboarding pages (model data)
final List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    image: "assets/images/intro/financial_planning_1.png",
    title: "Welcome to Finyx!",
    message:
        "Take control of your finances effortlessly track, save, and grow with ease",
  ),
  OnboardingPage(
    image: "assets/images/intro/report_1.png",
    title: "Plan your finances",
    message:
        "Track your progress, and achieve your financial goals with confidence",
  ),
  OnboardingPage(
    image: "assets/images/intro/planning_1.png",
    title: "Take control of your finances!",
    message:
        "Plan wisely, manage efficiently, and achieve your financial goals with ease",
  ),
];
