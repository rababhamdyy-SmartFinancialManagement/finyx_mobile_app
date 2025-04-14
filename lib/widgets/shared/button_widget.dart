import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Color? backgroundColor; 
  const ButtonWidget({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
    this.backgroundColor,  
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth > 600 ? width * 1.2 : width;
    double buttonHeight = screenHeight > 600 ? height * 1.2 : height;

    double fontSize = screenWidth > 600 ? 22 : 20;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Color(0xFF3E0555),  
        fixedSize: Size(buttonWidth, buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Color(0xFF000000).withAlpha(40),
        elevation: 10,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: "Righteous",
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}