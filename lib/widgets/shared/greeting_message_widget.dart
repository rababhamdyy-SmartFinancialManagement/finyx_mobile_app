import 'package:flutter/material.dart';

class GreetingMessageWidget extends StatelessWidget {
  final String greetingMessage;

  const GreetingMessageWidget({super.key, required this.greetingMessage});

  @override
  Widget build(BuildContext context) {
    return Text(
      greetingMessage,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: "REM",
      ),
      textAlign: TextAlign.center,
    );
  }
}
