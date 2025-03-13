import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          color:Color.fromARGB(122, 0, 0, 0),
        ),
        children: [
          TextSpan(
            text: isSignup ? "Already have an account? " : "New to Finyx? ",
          ),
          TextSpan(
            text: isSignup ? "Log in" : "Register Now",
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
