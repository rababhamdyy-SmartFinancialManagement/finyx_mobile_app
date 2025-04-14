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
    // جلب قيمة Dark Mode من SharedPreferences
    final theme = sharedPreferences?.getString('theme') ?? 'light';
    isDarkMode = theme == 'dark';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings', // Title displayed in the app bar
          style: TextStyle(fontFamily: 'Righteous', fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 32, 8, 0),
            child: Column(
              children: [
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
                CustomContainerButton(
                  text: "Push notifications",
                  onPressed: () {},
                  icon: Icons.arrow_forward_ios_outlined,
                  isSwitch: true,
                  initialSelected: true,
                ),
                CustomContainerButton(
                  text: "Dark mode",
                  onPressed: () {},
                  icon: Icons.arrow_forward_ios_outlined,
                  isSwitch: true,
                  initialSelected:
                      isDarkMode, // تحديد الحالة الأولية للـ Switch
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
