import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final String asset;
  final VoidCallback? onTap;
  final double screenWidth;

  const SocialIconButton({
    super.key,
    required this.asset,
    this.onTap,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.12,
        height: screenWidth * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle, 
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3), 
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            asset,
            width: screenWidth * 0.07,
            height: screenWidth * 0.07,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
