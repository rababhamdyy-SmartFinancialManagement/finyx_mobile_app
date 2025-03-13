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
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = screenWidth > 600 ? fontSize : 24;

    return Text(
      greetingText,
      style: TextStyle(
        fontSize: responsiveFontSize,
        fontWeight: FontWeight.bold,
        fontFamily: "Righteous",
      ),
    );
  }
}
