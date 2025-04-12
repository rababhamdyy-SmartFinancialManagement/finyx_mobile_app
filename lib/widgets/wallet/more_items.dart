import 'package:flutter/material.dart';

class MoreItems extends StatelessWidget {
  const MoreItems({super.key});

  @override
  Widget build(BuildContext context) {
    Color iconColor = Color(0xFF3E0555);
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(
        child: Text(
          'Add New Bill',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
