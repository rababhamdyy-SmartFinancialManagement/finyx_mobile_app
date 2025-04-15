import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  final double screenHeight;
  final Color? iconColor;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color effectiveBackgroundColor =
        backgroundColor ??
        theme.textTheme.bodyMedium?.color?.withAlpha(20) ??
        Color(0xFFFFFFFF);

    final Color effectiveIconColor =
        iconColor ?? theme.iconTheme.color ?? Colors.white;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: screenWidth * 0.15,
      leading: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.04,
          top: screenHeight * 0.0,
        ),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            decoration: BoxDecoration(
              color: effectiveBackgroundColor.withAlpha(
                35,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: effectiveIconColor,
              size: screenWidth * 0.05,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
