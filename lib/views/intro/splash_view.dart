import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:finyx_mobile_app/widgets/splash/finyx_widget.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));

      if (!context.mounted) return;

      final isLoggedIn = await SharedPrefsHelper.getLoginState();
      final userTypeStr = await SharedPrefsHelper.getUserType();
      final userType =
          userTypeStr == 'business' ? UserType.business : UserType.individual;

      if (isLoggedIn) {
        Navigator.pushReplacementNamed(
          context,
          '/homepage',
          arguments: userType,
        );
      } else {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = (screenWidth * 0.15).clamp(32, 72);

    return GestureDetector(
      onTap: () async {
        final isLoggedIn = await SharedPrefsHelper.getLoginState();
        final userTypeStr = await SharedPrefsHelper.getUserType();
        final userType =
            userTypeStr == 'business' ? UserType.business : UserType.individual;

        if (!context.mounted) return;

        if (isLoggedIn) {
          Navigator.pushReplacementNamed(
            context,
            '/homepage',
            arguments: userType,
          );
        } else {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/intro/logo_pic.png',
                width: (screenWidth * 0.9),
                height: (screenHeight * 0.5),
              ),
              FinyxWidget(fontSize: fontSize),
            ],
          ),
        ),
      ),
    );
  }
}
