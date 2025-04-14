import 'dart:io';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileHeader extends StatelessWidget {
  final String name;

  const EditProfileHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final image =
                state.imagePath.isNotEmpty
                    ? FileImage(File(state.imagePath))
                    : const AssetImage('assets/images/profile/profile.png')
                        as ImageProvider;

            return Stack(
              alignment: Alignment.bottomRight,
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
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (context) => _imagePickerBottomSheetWidget(context),
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
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                state.name,
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            );
          },
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