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
    required this.screenWidth,
    required this.screenHeight,
    this.titleColor,
    this.subtitleColor,
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
            color: titleColor ?? Theme.of(context).textTheme.titleLarge?.color, // اللون من الـ theme لو مفيش لون مخصص
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenHeight * 0.04),
        if (subtitle != null && subtitle!.isNotEmpty)
          Text(
            subtitle!,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: screenWidth * 0.04,
              color: subtitleColor ?? Theme.of(context).textTheme.bodyMedium?.color, // اللون من الـ theme لو مفيش لون مخصص
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
