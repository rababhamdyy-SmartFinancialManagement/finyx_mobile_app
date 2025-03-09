import 'package:finyx_mobile_app/views/forgetPassword_view.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/views/splash_view.dart';
import 'package:finyx_mobile_app/views/first_view.dart';
import 'package:finyx_mobile_app/views/second_view.dart';
import 'package:finyx_mobile_app/views/third_view.dart';
import 'package:finyx_mobile_app/views/login_view.dart';
import 'package:finyx_mobile_app/views/sign_up_view.dart';

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

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => SplashScreen(),
      firstScreen: (context) => FirstScreen(),
      secondScreen: (context) => SecondScreen(),
      thirdScreen: (context) => ThirdScreen(),
      login: (context) => LoginScreen(),
      signUp: (context) => SignUpScreen(),
      forgetPassword: (context) => ForgetPasswordScreen(),
    };
  }
}
