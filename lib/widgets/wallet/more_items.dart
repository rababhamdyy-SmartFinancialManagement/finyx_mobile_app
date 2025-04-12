import 'package:flutter/material.dart';

class MoreItems extends StatelessWidget {
  const MoreItems({super.key});

  @override
  Widget build(BuildContext context) {
    Color iconColor = Color(0xFF3E0555); // Define the primary icon color

    return AlertDialog(
      backgroundColor: Colors.white, // Set background color of the dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), // Apply rounded corners to the dialog
      title: Center(
        child: Text(
          'Add New Bill', // Title of the dialog
          style: TextStyle(
            fontSize: 20, // Set font size
            fontWeight: FontWeight.bold, // Set font weight to bold
            fontFamily: "Poppins", // Set custom font
            color: iconColor, // Set title color
          ),
        ),
      ),
      // Content section can be expanded later to add more widgets or information as needed
    );
  }
}
