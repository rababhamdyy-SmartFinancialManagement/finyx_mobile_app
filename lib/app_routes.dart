import 'package:finyx_mobile_app/views/auth_views/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/views/splash_view.dart';
import 'package:finyx_mobile_app/views/first_view.dart';
import 'package:finyx_mobile_app/views/second_view.dart';
import 'package:finyx_mobile_app/views/third_view.dart';
import 'views/auth_views/business_signup_view.dart';
import 'views/auth_views/changed_password_view.dart';
import 'views/auth_views/individual_signup_view.dart';
import 'views/auth_views/login_view.dart';
import 'views/auth_views/otp_view.dart';
import 'views/auth_views/reset_password_view.dart';
import 'views/auth_views/sign_up_view.dart';


class AppRoutes {
  static const String splash = '/';
  static const String firstScreen = '/firstScreen';
  static const String secondScreen = '/secondScreen';
  static const String thirdScreen = '/thirdScreen';
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String forgetPassword = '/forget_password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String individualSignup = '/individual_signup';
  static const String businessSignup = '/business_signup';
  static const String otp = '/otp_view';
  static const String resetPassword = '/reset_password_view';
  static const String passwordChanged = '/password_changed_view';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => SplashScreen(),
      firstScreen: (context) => FirstScreen(),
      secondScreen: (context) => SecondScreen(),
      thirdScreen: (context) => ThirdScreen(),
      login: (context) => LoginScreen(),
      signUp: (context) => SignUpScreen(),
      forgetPassword: (context) => ForgetPasswordScreen(),
      individualSignup: (context) => IndividualSignupView(),
      businessSignup: (context) => BusinessSignUpView(),
      otp: (context) => OtpView(),
      resetPassword: (context) => ResetPasswordScreen(),
      passwordChanged: (context) => PasswordChangedScreen(),
    };
  }
}
