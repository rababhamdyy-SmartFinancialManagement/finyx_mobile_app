import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Poppins",
          color: Color(0xFF2F80ED),
        ),
        children: [
          TextSpan(
            text: "New to Finyx ? ",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: "Register Now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline, 
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(
                  context,
                  '/sign_up', 
                );
              },
          ),
        ],
      ),
    );
  }
}
