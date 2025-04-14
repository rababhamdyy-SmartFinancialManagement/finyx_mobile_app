import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.fontSize,
    required this.text,
    this.isBold = false,
    this.isCentered = false,
  });

  final double fontSize;
  final String text;
  final bool isBold;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
    );
  }
}
