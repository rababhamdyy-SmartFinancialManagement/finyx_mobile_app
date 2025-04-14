import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: -screenHeight * 0.1,
          left: -screenWidth * 0.3,
          child: Image.asset(
            "assets/images/background_1.png",
            width: screenWidth * 1.3,
          ),
        ),
        Positioned(
          top: -screenHeight * 0.15,
          right: -screenWidth * 0.3,
          child: Image.asset(
            "assets/images/background_2.png",
            width: screenWidth * 1.3,
          ),
        ),
      ],
    );
  }
}
