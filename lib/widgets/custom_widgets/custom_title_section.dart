import 'package:flutter/material.dart';

class CustomTitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final double screenWidth;
  final double screenHeight;

  const CustomTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.08),
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.08,
            fontFamily: "Rockwell",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenHeight * 0.04),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white70,
            fontFamily: "Poppins",
            fontSize: screenWidth * 0.04,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
