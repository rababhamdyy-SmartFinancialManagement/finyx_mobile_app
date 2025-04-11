import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 600 ? 16 : 14;

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: fontSize, fontFamily: "Poppins"),
        children: [
          TextSpan(
            text: "New to Finyx ? ",
            style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF8D8D8D)),
          ),
          TextSpan(
            text: "Register Now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F80ED),
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
          ),
        ],
      ),
    );
  }
}
