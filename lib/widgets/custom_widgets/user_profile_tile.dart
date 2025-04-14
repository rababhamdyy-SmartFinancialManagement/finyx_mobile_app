import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';

class UserProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  state.imagePath != null
                      ? FileImage(File(state.imagePath!))
                      : null,
              child:
                  state.imagePath == null ? Icon(Icons.person, size: 50) : null,
            ),
            SizedBox(height: 16),
            Text(
              state.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Righteous',
              ),
            ),
            SizedBox(height: 8),
            Text(
              state.email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        );
      },
    );
  }
}
