import 'package:finyx_mobile_app/widgets/buttons_widgets/custom_container_button.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings', // Title displayed in the app bar
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 25,
          ), 
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
                  text: "Pivacy policy",
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
