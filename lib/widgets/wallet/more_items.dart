import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:flutter/material.dart';

class MoreItems extends StatelessWidget {
  const MoreItems({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color iconColor = const Color(0xFF3E0555);
    final Color textColor = isDark ? Colors.white : iconColor;
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: theme.dialogTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(
        child: Text(
          loc.translate("addNewBill"),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: textColor, 
          ),
        ),
      ),
    );
  }
}
