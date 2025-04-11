import 'package:finyx_mobile_app/widgets/buttons_widgets/custom_container_button.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';
import 'package:finyx_mobile_app/widgets/shared/curved_background_widget.dart';
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
                    fontSize: MediaQuery.of(context).size.width * 0.0003,
                    color: Colors.white,
                    text: 'Settings',
                    isBold: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  CustomContainerButton(
                    text: "About us",
                    onPressed: () {},
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  CustomContainerButton(
                    text: "Pivacy policy",
                    onPressed: () {},
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  CustomContainerButton(
                    text: "Terms and conditions",
                    onPressed: () {},
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
                    onPressed: () {},
                    icon: Icons.help_outline_outlined,
                    iconSize: 0.03,
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
