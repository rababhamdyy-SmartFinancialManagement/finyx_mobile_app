import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
              Image.asset('assets/images/splash_pic.png'),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 64, fontWeight: FontWeight.w700,fontFamily: "Rockwell"),
                  children: [
                    TextSpan(text: "Fin", style: TextStyle(color: Color(0xFFDA9220))),
                    TextSpan(text: "yx", style: TextStyle(color: Color(0xFF3E0555))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
