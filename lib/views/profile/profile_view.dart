import 'package:flutter/material.dart';
import '../../models/applocalization.dart';
import '../../widgets/buttons_widgets/custom_container_button.dart';
import '../../widgets/custom_widgets/dialogue.dart';
import '../../widgets/custom_widgets/user_profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        //profile
        title: Text(
          loc.translate("profile_title"),
          style: TextStyle(fontFamily: 'Righteous', fontSize: width * 0.06),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Column(
            children: [
              const UserProfileCard(),
              const SizedBox(height: 32),
              CustomContainerButton(
                text: loc.translate("edit_profile"),
                icon: Icons.edit,
                onPressed:
                    () => Navigator.pushNamed(context, '/edit_profile_view'),
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: loc.translate("change_password"),
                icon: Icons.lock_outline,
                onPressed:
                    () => Navigator.pushNamed(context, '/reset_password_view'),
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: loc.translate("delete_account"),
                icon: Icons.delete_outline,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialogue(
                      message: loc.translate("delete_account_confirmation"),
                      actionType: 'delete',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: loc.translate("log_out"),
                icon: Icons.logout,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialogue(
                      message: loc.translate("logout_confirmation"),
                      actionType: 'logout',
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
