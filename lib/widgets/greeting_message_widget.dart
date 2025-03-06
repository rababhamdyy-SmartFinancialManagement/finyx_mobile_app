import 'package:flutter/material.dart';

class GreetingMessageWidget extends StatelessWidget {
  final String greetingMessage;
  const GreetingMessageWidget({
    super.key,
    required this.greetingMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 350,
        child: Text(
          greetingMessage,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "REM",
          ),
          textAlign: TextAlign.left,
          softWrap: true,
          strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
        ),
      ),
    );
  }
}