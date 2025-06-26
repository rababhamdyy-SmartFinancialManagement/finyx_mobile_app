import 'dart:io';

import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String additionalInfo;
  final String? imagePath;

  const UserProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.additionalInfo,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        _buildProfileImage(width, imagePath),
        const SizedBox(height: 12),
        Text(
          name,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          email,
          style: TextStyle(
            fontSize: width * 0.04,
            color: Colors.grey[600],
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          additionalInfo,
          style: TextStyle(
            fontSize: width * 0.04,
            color: Colors.grey[600],
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(double width, String? imageUrl) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: const Color(0xFF3E0555)),
      ),
      child: CircleAvatar(
        radius: width * 0.19,
        backgroundColor: Colors.transparent,
        backgroundImage: _getImageProvider(imageUrl),
      ),
    );
  }

  ImageProvider _getImageProvider(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const AssetImage('assets/images/profile/profile2.png');
    }

    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    }

    try {
      final file = File(imageUrl);
      if (file.existsSync()) {
        return FileImage(file);
      }
    } catch (e) {
      debugPrint('Invalid file path for image: $e');
    }

    return const AssetImage('assets/images/profile/profile2.png');
  }
}
