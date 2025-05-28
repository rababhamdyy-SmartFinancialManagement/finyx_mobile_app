import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:flutter/material.dart';
import 'auth_footer_text_widget.dart';
import '../buttons_widgets/social_icon_button_widget.dart';
import '../../models/login_model.dart';

class SocialAuthButtons extends StatefulWidget {
  final bool isSignup;

  const SocialAuthButtons({super.key, this.isSignup = true});

  @override
  State<SocialAuthButtons> createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends State<SocialAuthButtons> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

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
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withAlpha(150),
                ),
              ),
              Text(
                loc.translate("RegisterWith"),
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withAlpha(200),
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Divider(
                  height: 0.0,
                  thickness: 0.7,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withAlpha(150),
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
              onTap: () {
                // Placeholder for Facebook login
              },
              screenWidth: screenWidth,
            ),
            SocialIconButton(
              asset: "assets/images/icons/google.png",
              onTap: () async {
                final loginModel = LoginModel();
                final userType = await loginModel.signInWithGoogle(context);
                if (userType != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    '/homepage',
                    arguments: userType,
                  );
                }
              },
              screenWidth: screenWidth,
            ),
            SocialIconButton(
              asset: "assets/images/icons/apple.png",
              onTap: () {
                // Placeholder for Apple login
              },
              screenWidth: screenWidth,
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.07),
        AuthFooterText(isSignup: widget.isSignup, screenWidth: screenWidth),
      ],
    );
  }
}
