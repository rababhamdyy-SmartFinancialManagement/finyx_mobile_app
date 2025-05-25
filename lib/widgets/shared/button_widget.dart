import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed, 
    this.backgroundColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonWidth = screenWidth > 600 ? width * 1.2 : width;
    final buttonHeight = screenHeight > 600 ? height * 1.2 : height;
    final double fontSize = screenWidth > 600 ? 22.0 : 20.0;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color(0xFF3E0555),
        fixedSize: Size(buttonWidth, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: const Color(0xFF000000).withAlpha(40),
        elevation: 10,
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
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