import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/views/first_view.dart';
import 'package:finyx_mobile_app/views/splash_view.dart';
import 'package:finyx_mobile_app/views/sign_up_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String firstScreen = '/firstScreen';
  static const String signUp = '/sign_up';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => SplashScreen(),
      firstScreen: (context) => FirstScreen(),
      signUp: (context) => SignUpScreen(),
    };
  }
}
