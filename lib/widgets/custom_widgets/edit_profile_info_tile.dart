import 'package:flutter/material.dart';

class EditProfileInfoTile extends StatelessWidget {
  final String iconPath;
  final String text;
  final String fieldName;
  final VoidCallback onEdit;

  const EditProfileInfoTile({
    super.key,
    required this.iconPath,
    required this.text,
    required this.fieldName,
    required this.onEdit,
  });

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
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.purple),
        onPressed: onEdit,
      ),
      onTap: onEdit,
    );
  }
}