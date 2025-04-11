import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/home/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/views/intro/splash_view.dart';
import 'package:finyx_mobile_app/views/intro/onboarding_view.dart';
import 'package:finyx_mobile_app/views/auth/login_view.dart';
import 'package:finyx_mobile_app/views/auth/sign_up_view.dart';
import 'package:finyx_mobile_app/views/auth/forget_password_view.dart';
import 'package:finyx_mobile_app/views/auth/otp_view.dart';
import 'package:finyx_mobile_app/views/auth/reset_password_view.dart';
import 'package:finyx_mobile_app/views/auth/individual_signup_view.dart';
import 'package:finyx_mobile_app/views/auth/business_signup_view.dart';
import 'package:finyx_mobile_app/views/auth/changed_password_view.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => SplashScreen(),
    '/onboarding': (_) => OnboardingScreen(),
    '/login': (_) => LoginScreen(),
    '/sign_up': (_) => SignUpScreen(),
    '/forget_password' : (_) => ForgetPasswordScreen(),
    '/otp_view' : (_) => OtpView(),
    '/password_changed_view' : (_) => PasswordChangedScreen(),
    '/reset_password_view' : (_) => ResetPasswordScreen(),
    '/individual_signup' : (_) => IndividualSignupView(),
    '/business_signup' : (_) => BusinessSignUpView(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Assuming UserType is passed as an argument when navigating to the homepage
    if (settings.name == '/homepage') {
      final userType = settings.arguments as UserType? ?? UserType.individual;
      return MaterialPageRoute(
        builder: (_) => HomepageView(userType: userType),
      );
    }

    final builder = routes[settings.name];
    return MaterialPageRoute(
      builder: builder ?? (_) => Scaffold(
        body: Center(child: Text('Page Not Found')),
      ),
    );
  }
}
