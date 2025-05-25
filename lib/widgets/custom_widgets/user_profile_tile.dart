import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final image =
            state.imagePath != null && state.imagePath!.isNotEmpty
                ? FileImage(File(state.imagePath!))
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
              child: CircleAvatar(backgroundImage: image, radius: width * 0.19),
            ),
            const SizedBox(height: 12),
            Text(
              state.name,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
                // color: ,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              state.email,
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
}
