import 'dart:io';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final imageWidth = screenWidth * 0.16;
    final imageHeight = screenHeight * 0.08;
    final fontSize = 18 * (screenWidth / 375);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final image =
            state.imagePath.isNotEmpty
                ? FileImage(File(state.imagePath))
                : const AssetImage('assets/images/profile/profile.png')
                    as ImageProvider;

        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CircleAvatar(
                radius: imageWidth / 2,
                backgroundImage: image,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              state.name,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        );
      },
    );
  }
}
