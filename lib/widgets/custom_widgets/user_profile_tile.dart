import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.25;
    final fontSize = 18 * (screenWidth / 375);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final image =
            state.imagePath.isNotEmpty
                ? FileImage(File(state.imagePath))
                : const AssetImage('assets/images/profile/profile.png')
                    as ImageProvider;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: const Color(0xFF3E0555)),
              ),
              child: CircleAvatar(
                radius: imageSize / 1.5,
                backgroundImage: image,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              state.name,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        );
      },
    );
  }
}