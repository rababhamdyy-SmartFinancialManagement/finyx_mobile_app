import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';

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
        backgroundImage: imageUrl != null ? _getImageProvider(imageUrl) : null,
        child: imageUrl == null
            ? ClipOval(
          child: Image.asset(
            'assets/images/profile/profile2.png',
            width: width * 0.38,
            height: width * 0.38,
            fit: BoxFit.cover,
          ),
        )
            : null,
      ),
    );
  }

  ImageProvider _getImageProvider(String? imageUrl) {
    if (imageUrl == null) {
      return const AssetImage('assets/images/profile/profile2.png');
    }

    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else {
      return FileImage(File(imageUrl));
    }
  }
}