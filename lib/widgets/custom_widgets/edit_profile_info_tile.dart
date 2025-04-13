import 'package:flutter/material.dart';

class EditProfileInfoTile extends StatelessWidget {
  final String iconPath;
  final String text;

  const EditProfileInfoTile({super.key, required this.iconPath, required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ListTile(
      leading: Image.asset(iconPath),
      title: Text(
        text,
        style: TextStyle(
          fontSize: width * 0.05,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
