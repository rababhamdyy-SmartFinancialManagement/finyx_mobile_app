import 'package:finyx_mobile_app/cubits/app_theme/app_theme_cubit.dart';
import 'package:finyx_mobile_app/helpers/constants.dart';
import 'package:finyx_mobile_app/models/theme_state_enum.dart';
import 'package:finyx_mobile_app/widgets/buttons_widgets/custom_container_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    final theme = shared_preferences?.getString('theme') ?? 'light';
    isDarkMode = theme == 'dark';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: MediaQuery.of(context).size.width * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section: General
                Text(
                  "General",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                CustomContainerButton(
                  text: "About us",
                  onPressed: () {
                    Navigator.pushNamed(context, '/AboutUs');
                  },
                  icon: Icons.arrow_forward_ios_outlined,
                ),
                CustomContainerButton(
                  text: "Privacy policy",
                  onPressed: () {
                    Navigator.pushNamed(context, '/PrivacyPolicy');
                  },
                  icon: Icons.arrow_forward_ios_outlined,
                ),
                CustomContainerButton(
                  text: "Terms and conditions",
                  onPressed: () {
                    Navigator.pushNamed(context, '/TermsAndConditions');
                  },
                  icon: Icons.arrow_forward_ios_outlined,
                ),
                const SizedBox(height: 24),
                Divider(thickness: 1, color: Colors.grey.shade300),
                const SizedBox(height: 24),

                // Section: App Preferences
                Text(
                  "App Preferences",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                CustomContainerButton(
                  text: "Push notifications",
                  onPressed: () {},
                  icon: Icons.notifications_outlined,
                  isSwitch: true,
                  initialSelected: true,
                ),
                CustomContainerButton(
                  text: "Dark mode",
                  onPressed: () {},
                  icon: Icons.dark_mode_outlined,
                  isSwitch: true,
                  initialSelected: isDarkMode,
                  onSwitchChanged: (isDark) {
                    if (isDark) {
                      context.read<AppThemeCubit>().changeTheme(
                        ThemeStateEnum.dark,
                      );
                    } else {
                      context.read<AppThemeCubit>().changeTheme(
                        ThemeStateEnum.light,
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                Divider(thickness: 1, color: Colors.grey.shade300),
                const SizedBox(height: 24),

                // Section: Support
                Text(
                  "Support",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                CustomContainerButton(
                  text: "Help & Support",
                  onPressed: () {
                    Navigator.pushNamed(context, '/HelpSupport');
                  },
                  icon: Icons.help_outline_outlined,
                  iconSize: 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
