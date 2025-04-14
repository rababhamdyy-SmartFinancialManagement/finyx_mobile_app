import 'package:flutter/material.dart';

class MoreItems extends StatelessWidget {
  const MoreItems({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color iconColor = const Color(0xFF3E0555);
    final Color textColor = isDark ? Colors.white : iconColor;

    return AlertDialog(
      backgroundColor: theme.dialogBackgroundColor, // ← ياخد اللون من الثيم
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(
        child: Text(
          'Add New Bill',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: textColor, // ← يتغير حسب المود
          ),
        ),
      ),
      // تقدر تضيف Widgets تانية هنا بعدين في الـ content
    );
  }
}
