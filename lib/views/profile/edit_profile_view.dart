import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../widgets/custom_widgets/edit_profile_header.dart';
import '../../widgets/custom_widgets/edit_profile_info_tile.dart';
import '../../models/user_model.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final user = UserModel(
      name: 'Yennefer Doe',
      email: 'Yennefer22@gmail.com',
      birthDate: '22 / 2 / 1990',
      location: 'Cairo , Egypt',
      idNumber: '30225696944566',
      salary: '2000\$',
      profileImage: 'assets/images/profile/profile.png',
    );

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.11),
              EditProfileHeader(user: user),
              SizedBox(height: height * 0.03),
              Divider(
                color: const Color(0xFFCACACA),
                thickness: 0.5,
                indent: width * 0.01,
                endIndent: width * 0.01,
              ),
              EditProfileInfoTile(
                iconPath: "assets/images/profile/User(1).png",
                text: user.name,
              ),
              EditProfileInfoTile(
                iconPath: "assets/images/profile/🦆 icon _mail_.png",
                text: user.email,
              ),
              EditProfileInfoTile(
                iconPath: "assets/images/profile/calendar 1.png",
                text: user.birthDate,
              ),
              EditProfileInfoTile(
                iconPath: "assets/images/profile/location 1.png",
                text: user.location,
              ),
              EditProfileInfoTile(
                iconPath: "assets/images/profile/id 1.png",
                text: user.idNumber,
              ),
              EditProfileInfoTile(
                iconPath: "assets/images/profile/wages 1.png",
                text: user.salary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
