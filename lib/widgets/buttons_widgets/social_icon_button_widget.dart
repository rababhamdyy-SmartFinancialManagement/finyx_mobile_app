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
      child: CircleAvatar(
        radius: screenWidth * 0.06,
        // backgroundColor: Colors.grey[200],
        child: Image.asset(asset),
      ),
    );
  }
}
