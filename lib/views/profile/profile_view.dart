import 'package:flutter/material.dart';
import '../../widgets/buttons_widgets/custom_container_button.dart';
import '../../widgets/custom_widgets/dialogue.dart';
import '../../widgets/custom_widgets/user_profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: width * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Column(
            children: [
              // نرجّع الكارد اللي فيه البيانات الفعلية للمستخدم
              UserProfileCard(),
              const SizedBox(height: 32),
              CustomContainerButton(
                text: "Edit Profile",
                icon: Icons.edit,
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_profile_view');
                },
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: "Change Password",
                icon: Icons.lock_outline,
                onPressed: () {
                  Navigator.pushNamed(context, '/reset_password_view');
                },
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: "Delete Account",
                icon: Icons.delete_outline,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialogue(
                      message:
                          "Are you sure you want to delete your account ?",
                      onConfirm: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: "Logout",
                icon: Icons.logout,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialogue(
                      message: "Are you sure you want to logout?",
                      onConfirm: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
