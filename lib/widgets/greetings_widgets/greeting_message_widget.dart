import 'package:flutter/material.dart';

class GreetingMessageWidget extends StatelessWidget {
  final String greetingMessage;

  const GreetingMessageWidget({super.key, required this.greetingMessage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = screenWidth > 600 ? 18 : 16;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Text(
        greetingMessage,
        style: TextStyle(
          fontSize: responsiveFontSize,
          fontWeight: FontWeight.w500,
          fontFamily: "REM",
        ),
        textAlign: TextAlign.start,
        softWrap: true,
        strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
      ),
    );
  }
}
