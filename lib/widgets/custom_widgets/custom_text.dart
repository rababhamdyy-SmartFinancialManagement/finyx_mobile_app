import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.fontSize,
    required this.color,
    required this.text,
    this.isBold = false,
  });

  final double fontSize;
  final Color color;
  final String text;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * fontSize,
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      ),
    );
  }
}