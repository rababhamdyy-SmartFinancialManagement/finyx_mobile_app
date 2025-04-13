import 'package:flutter/material.dart';

class EditProfileInfoTile extends StatelessWidget {
  final Icon iconPath;
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFEDE7F6),
            child: Icon(iconPath.icon, color: const Color(0xFF3E0555)),
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: width * 0.045,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF3E0555)),
            onPressed: onEdit,
          ),
        ),
      ),
    );
  }
}
