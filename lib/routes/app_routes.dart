import 'package:finyx_mobile_app/views/auth/login_view.dart';
import 'package:finyx_mobile_app/views/auth/sign_up_view.dart';
import 'package:finyx_mobile_app/views/intro/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/views/intro/splash_view.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => SplashScreen(),
    '/onboarding': (_) => OnboardingScreen(),
    '/login': (_) => LoginScreen(),
    '/sign_up': (_) => SignUpScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    return MaterialPageRoute(
      builder: builder ?? (_) => Scaffold(
        body: Center(child: Text('Page Not Found')),
      ),
    );
  }
}
