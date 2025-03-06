import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:finyx_mobile_app/widgets/finyx_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Ensure the screen is still on before performing the navigation.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 10), () {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/firstScreen');
        }
      });
    });

    // To get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = (screenWidth * 0.15).clamp(32, 72);

    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/firstScreen');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //dynamic pic
              Image.asset(
                'assets/images/logo_pic.png',
                width: (screenWidth * 0.9),
                height: (screenHeight * 0.5),
              ),
              //SizedBox(height: screenHeight * 0.02),

              //dynamic font size
              FinyxWidget(fontSize: fontSize),
            ],
          ),
        ),
      ),
    );
  }
}
