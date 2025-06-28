import 'package:finyx_mobile_app/cubits/app_language/app_language_cubit.dart';
import 'package:finyx_mobile_app/cubits/app_theme/app_theme_cubit.dart';
import 'package:finyx_mobile_app/helpers/constants.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/models/theme_state_enum.dart';
import 'package:finyx_mobile_app/widgets/buttons_widgets/custom_container_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/models/language_event_type.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  @override
  void initState() {
    super.initState();
    final theme = sharedPreferences?.getString('theme') ?? 'light';
    _isDarkMode = theme == 'dark';
    _notificationsEnabled = sharedPreferences?.getBool('notifications') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          loc.translate("Settings_title"),
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: MediaQuery.of(context).size.width * 0.06,
          ),
        ),
        centerTitle: true,
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
                  loc.translate("General"),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                CustomContainerButton(
                  text: loc.translate("About_Us"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/AboutUs');
                  },
                  icon: Icons.arrow_forward_ios_outlined,
                ),
                CustomContainerButton(
                  text: loc.translate("Privacy_Policy"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/PrivacyPolicy');
                  },
                  icon: Icons.arrow_forward_ios_outlined,
                ),
                CustomContainerButton(
                  text: loc.translate("Terms_Conditions"),
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
                  loc.translate("App_Preferences"),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                CustomContainerButton(
                  text: loc.translate("Push_notifications"),
                  onPressed: () {},
                  icon: Icons.notifications_outlined,
                  isSwitch: true,
                  initialSelected: _notificationsEnabled,
                  onSwitchChanged: (enabled) async {
                    setState(() {
                      _notificationsEnabled = enabled;
                    });

                    await sharedPreferences?.setBool('notifications', enabled);

                    if (enabled) {
                      await FirebaseMessaging.instance.subscribeToTopic(
                        'general',
                      );
                    } else {
                      await FirebaseMessaging.instance.unsubscribeFromTopic(
                        'general',
                      );
                    }
                  },
                ),

                CustomContainerButton(
                  text: loc.translate("Dark_mode"),
                  onPressed: () {},
                  icon: Icons.dark_mode_outlined,
                  isSwitch: true,
                  initialSelected: _isDarkMode,
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
                BlocBuilder<AppLanguageCubit, AppLanguageState>(
                  builder: (context, state) {
                    bool isEnglish = true;
                    if (state is AppChangeLanguage) {
                      isEnglish = state.languageCode == 'en';
                    }

                    return CustomContainerButton(
                      text: loc.translate("Language"),
                      icon: Icons.language,
                      isSwitch: true,
                      isLanguageSwitch: true,
                      initialSelected: isEnglish,
                      onSwitchChanged: (val) {
                        context.read<AppLanguageCubit>().AppLanguageFunc(
                          val
                              ? LangaugeEventEnums.EnglishLanguage
                              : LangaugeEventEnums.ArbicLanguage,
                        );
                      },
                      onPressed: () {},
                    );
                  },
                ),
                const SizedBox(height: 24),
                Divider(thickness: 1, color: Colors.grey.shade300),
                const SizedBox(height: 24),

                // Section: Support
                Text(
                  loc.translate("Support"),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                CustomContainerButton(
                  text: loc.translate("Help_Support"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/HelpSupport');
                  },
                  icon: Icons.help_outline_outlined,
                  iconSize: 0.03,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
