class OnboardingPageModel {
  final String imageAsset;
  final String greetingText;
  final String messageText;
  final int indicatorIndex;
  final String buttonText;

  OnboardingPageModel({
    required this.imageAsset,
    required this.greetingText,
    required this.messageText,
    required this.indicatorIndex,
    required this.buttonText,
  });

  static final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      imageAsset: "assets/images/intro/financial_planning_1.png",
      greetingText: "Welcome to Finyx!",
      messageText:
          "Take control of your finances effortlessly track, save, and grow with ease",
      indicatorIndex: 0,
      buttonText: "Next",
    ),
    OnboardingPageModel(
      imageAsset: "assets/images/intro/report_1.png",
      greetingText: "Plan your finances",
      messageText:
          "Track your progress, and achieve your financial goals with confidence",
      indicatorIndex: 1,
      buttonText: "Next",
    ),
    OnboardingPageModel(
      imageAsset: "assets/images/intro/planning_1.png",
      greetingText: "Take control of your finances!",
      messageText:
          "Plan wisely, manage efficiently, and achieve your financial goals with ease",
      indicatorIndex: 2,
      buttonText: "Get Started",
    ),
  ];
}
