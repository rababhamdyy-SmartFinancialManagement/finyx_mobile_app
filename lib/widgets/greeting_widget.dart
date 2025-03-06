import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  final String greetingText;
  final double fontSize;
  const GreetingWidget({
    super.key,
    required this.greetingText,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      greetingText,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: "Righteous",
      ),
    );
  }
}