import 'package:flutter/material.dart';

class CustomTitleSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double screenWidth;
  final double screenHeight;
  final Color? titleColor;
  final Color? subtitleColor;

  const CustomTitleSection({
    super.key,
    required this.title,
    this.subtitle,
    this.titleColor = Colors.white,
    this.subtitleColor = Colors.white70,
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
            color: titleColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenHeight * 0.04),
        if (subtitle != null && subtitle!.isNotEmpty)
          Text(
            subtitle!,
            style: TextStyle(
              color: subtitleColor,
              fontFamily: "Poppins",
              fontSize: screenWidth * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
