import 'package:flutter/material.dart';

class FinyxWidget extends StatelessWidget {
  final double fontSize;
  const FinyxWidget({super.key , required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          fontFamily: "Rockwell",
        ),
        children: [
          TextSpan(text: "Fin", style: TextStyle(color: Color(0xFFDA9220))),
          TextSpan(text: "yx", style: TextStyle(color: Color(0xFF3E0555))),
        ],
      ),
    );
  }
}
