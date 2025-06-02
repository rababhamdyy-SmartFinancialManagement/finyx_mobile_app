import 'dart:io';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileHeader extends StatelessWidget {
  final String? name;

  const EditProfileHeader({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final imageUrl = state.imagePath ?? user?.photoURL;

            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFF3E0555),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: width * 0.19,
                    backgroundColor:
                        Colors.transparent, // لجعل الخلفية شفافة إذا لزم الأمر
                    backgroundImage:
                        imageUrl != null ? _getImageProvider(imageUrl) : null,
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
                state.name.isNotEmpty
                    ? state.name
                    : user?.displayName ?? 'User',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            );
          },
        ),
      ],
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
              onPressed: () async {
                Navigator.pop(context);
                await context.read<ProfileCubit>().pickImage(
                  ImageSource.gallery,
                );
              },
              icon: const Icon(Icons.image, color: Colors.blue, size: 50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                Navigator.pop(context);
                await context.read<ProfileCubit>().pickImage(
                  ImageSource.camera,
                );
              },
              icon: const Icon(Icons.camera, color: Colors.blue, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
