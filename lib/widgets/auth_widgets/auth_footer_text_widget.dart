import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/applocalization.dart'; // تأكد أنك مستورد AppLocalizations

class AuthFooterText extends StatelessWidget {
  final bool isSignup;
  final double screenWidth;

  const AuthFooterText({
    super.key,
    required this.isSignup,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          color: Theme.of(context).textTheme.bodyMedium!.color!.withAlpha(150),
        ),
        children: [
          TextSpan(
            text:
                isSignup
                    ? loc.translate("already_have_account")
                    : loc.translate("new_to_finyx"),
          ),
          TextSpan(
            text:
                isSignup
                    ? loc.translate("login")
                    : loc.translate("register_now"),
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: const Color(0xFF2F80ED),
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap =
                      isSignup
                          ? () {
                            Navigator.pushNamed(context, '/login');
                          }
                          : () {
                            Navigator.pushNamed(context, '/sign_up');
                          },
          ),
        ],
      ),
    );
  }
}
