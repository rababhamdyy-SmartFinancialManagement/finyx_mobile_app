import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/views/splash_view.dart';
import 'package:finyx_mobile_app/views/onboarding_view.dart'; 
import 'package:finyx_mobile_app/views/login_view.dart';
import 'package:finyx_mobile_app/views/sign_up_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboardingScreen = '/onboardingScreen'; 
  static const String login = '/login';
  static const String signUp = '/sign_up';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => SplashScreen(),
      onboardingScreen: (context) {
        final int currentIndex = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
        return OnboardingScreen(currentIndex: currentIndex);
      },
      login: (context) => LoginScreen(),
      signUp: (context) => SignUpScreen(),
    };
  }
}
