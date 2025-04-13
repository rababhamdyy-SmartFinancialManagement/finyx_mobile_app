import 'package:finyx_mobile_app/widgets/custom_widgets/user_profile_tile.dart';
import 'package:flutter/material.dart';

import '../../widgets/buttons_widgets/custom_container_button.dart';
import '../../widgets/custom_widgets/custom_text.dart';
import '../../widgets/custom_widgets/dialogue.dart';
import '../../widgets/shared/curved_background_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: CurvedBackgroundPainter(context),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.21),

                  CustomText(
                    fontSize: MediaQuery.of(context).size.width * 0.0002,
                    color: Colors.white,
                    text: 'Profile',
                    isBold: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  UserProfileCard(),
                  Divider(
                    color: Color(0xFFCACACA),
                    thickness: 0.5,
                    indent: MediaQuery.of(context).size.width * 0.01,
                    endIndent: MediaQuery.of(context).size.width * 0.01,
                  ),

                  CustomContainerButton(
                    text: "Edit Profile",
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile_view');
                    },
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  CustomContainerButton(
                    text: "Change Password",
                    onPressed: () {
                      Navigator.pushNamed(context, '/reset_password_view');
                    },
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  CustomContainerButton(
                    text: "Delete Account",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialogue(
                          message: "Are you sure you want to delete your account?",
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                        )
                      );
                    },
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  CustomContainerButton(
                    text: "Logout",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialogue(
                            message: "Are you sure you want to  Logout?",
                            onConfirm: () {
                              Navigator.pop(context);
                            },
                          )
                      );
                    },
                    icon: Icons.logout_outlined,
                  ),



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}