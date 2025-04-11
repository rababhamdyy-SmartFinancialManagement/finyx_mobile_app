import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  final String greetingText;


  const GreetingWidget({
    super.key,
    required this.greetingText,

  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = screenWidth > 600 ? 27: 30;

    return Text(
      greetingText,
      style: TextStyle(
        fontSize: responsiveFontSize,
        fontWeight: FontWeight.bold,
        fontFamily: "Righteous",
      ), 
      textAlign: TextAlign.center,
    );
  }
}
