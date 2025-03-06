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
            children: [
              Image.asset('assets/images/logo_pic.png'),
              //SizedBox(height: 10),
              FinyxWidget(fontSize: 64),
            ],
          ),
        ),
      ),
    );
  }
}