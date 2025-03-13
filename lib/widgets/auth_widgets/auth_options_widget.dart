import 'package:flutter/material.dart';
import 'auth_footer_text_widget.dart';
import '../buttons_widgets/social_icon_button_widget.dart';

class SocialAuthButtons extends StatelessWidget {
  final bool isSignup;

  const SocialAuthButtons({super.key, this.isSignup = true});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  height: 0.0,
                  thickness: 0.7,
                  color: Color(0xB2000000),
                ),
              ),
              Text(
                " Or Register with ",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Color(0xB2000000),
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Divider(
                  height: 0.0,
                  thickness: 0.7,
                  color: Color(0xB2000000),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenWidth * 0.05),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: screenWidth * 0.05,
          runSpacing: 10,
          children: [
            SocialIconButton(
              asset: "assets/images/icons/facebook.png",
              onTap: () {},
              screenWidth: screenWidth,
            ),
            SocialIconButton(
              asset: "assets/images/icons/google.png",
              onTap: () {},
              screenWidth: screenWidth,
            ),
            SocialIconButton(
              asset: "assets/images/icons/apple.png",
              onTap: () {},
              screenWidth: screenWidth,
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.07),
        AuthFooterText(isSignup: isSignup, screenWidth: screenWidth),
      ],
    );
  }
}
