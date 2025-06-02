import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final imageUrl = state.imagePath ?? user?.photoURL;

        return Column(
          children: [
            _buildProfileImage(width, imageUrl),
            const SizedBox(height: 12),
            Text(
              state.name.isNotEmpty ? state.name : user?.displayName ?? 'User',
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 6),
            if ((state.email.isNotEmpty ? state.email : user?.email) != null)
              Text(
                state.email.isNotEmpty ? state.email : user!.email!,
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
              ),
          ],
        );
      },
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
        backgroundColor: Colors.transparent, // لجعل الخلفية شفافة إذا لزم الأمر
        backgroundImage: imageUrl != null ? _getImageProvider(imageUrl) : null,
        child:
            imageUrl == null
                ? ClipOval(
                  child: Image.asset(
                    'assets/images/profile/profile2.png',
                    width: width * 0.38, // (radius * 2)
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
