import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';

class UserProfileCard extends StatelessWidget {
  final String? name;
  final String? imagePath;

  const UserProfileCard({
    super.key,
    this.name,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final image = imagePath != null && imagePath!.isNotEmpty
        ? FileImage(File(imagePath!))
        : const AssetImage('assets/images/profile/profile.png')
    as ImageProvider;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Color(0xFF3E0555)),
          ),
          child: CircleAvatar(
            backgroundImage: image,
            radius: width * 0.19,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name ?? '',
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
