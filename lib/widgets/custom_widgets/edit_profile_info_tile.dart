import 'package:flutter/material.dart';

class EditProfileInfoTile extends StatelessWidget {
  final String iconPath; // Change this to a string for the asset path
  final String text;
  final String fieldName;
  final VoidCallback onEdit;

  const EditProfileInfoTile({
    super.key,
    required this.iconPath, // Use the asset path for image
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
            child: Image.asset(
              iconPath, // Use the asset path here
              width: 30, // Set a width and height for the image
              height: 30,
              fit:
                  BoxFit
                      .contain, // Ensure the image fits well inside the circle
            ),
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
