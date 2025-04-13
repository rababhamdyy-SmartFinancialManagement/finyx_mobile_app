import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';
import '../../models/user_model.dart';

class EditProfileHeader extends StatelessWidget {
  final UserModel user;

  const EditProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.0005),
          child: ListTile(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            title: Padding(
              padding: EdgeInsets.only(left: width * 0.09),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: width * 0.09,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'REM',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final image = state.imagePath.isNotEmpty
                ? FileImage(File(state.imagePath))
                : user.profileImage.isNotEmpty
                ? NetworkImage(user.profileImage)
                : const AssetImage('assets/images/profile/profile.png') as ImageProvider;

            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.purple),
                  ),
                  child: CircleAvatar(
                    backgroundImage: image,
                    radius: width * 0.19,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _imagePickerBottomSheetWidget(context),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: const Icon(
                        Icons.photo_camera,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Text(
          user.name,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _imagePickerBottomSheetWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().pickImage(ImageSource.gallery);
              },
              icon: Icon(Icons.image, color: Colors.blue, size: 50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().pickImage(ImageSource.camera);
              },
              icon: Icon(Icons.camera, color: Colors.blue, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
