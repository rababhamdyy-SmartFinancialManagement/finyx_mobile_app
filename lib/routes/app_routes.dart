import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/home/home_page_view.dart';
import 'package:finyx_mobile_app/views/profile/edit_profile_view.dart';
import 'package:finyx_mobile_app/views/profile/profile_view.dart';
import 'package:finyx_mobile_app/views/setting/about_us_view.dart';
import 'package:finyx_mobile_app/views/setting/help_support_view.dart';
import 'package:finyx_mobile_app/views/setting/privacy_policy_view.dart';
import 'package:finyx_mobile_app/views/setting/setting_view.dart';
import 'package:finyx_mobile_app/views/setting/terms_and_conditions_view.dart';
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
    '/forget_password': (_) => ForgetPasswordScreen(),
    '/otp_view': (_) => OtpView(),
    '/password_changed_view': (_) => PasswordChangedScreen(),
    '/reset_password_view': (_) => ResetPasswordScreen(),
    '/individual_signup': (_) => IndividualSignupView(),
    '/business_signup': (_) => BusinessSignUpView(),
    '/setting': (_) => SettingScreen(),
    '/PrivacyPolicy': (_) => PrivacyPolicyView(),
    '/TermsAndConditions': (_) => TermsAndConditionsView(),
    '/AboutUs': (_) => AboutUsView(),
    '/HelpSupport': (_) => HelpSupportView(),
    '/profile_view': (_) => ProfileScreen(),
    '/edit_profile_view': (_) => EditProfileScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == '/homepage') {
      final userType =
          settings.arguments is UserType
              ? settings.arguments as UserType
              : UserType.individual;
      return MaterialPageRoute(
        builder: (_) => HomePageView(userType: userType),
      );
    }

    final builder = routes[settings.name];
    return MaterialPageRoute(
      builder:
          builder ??
          (_) => Scaffold(body: Center(child: Text('Page Not Found'))),
    );
  }
}
