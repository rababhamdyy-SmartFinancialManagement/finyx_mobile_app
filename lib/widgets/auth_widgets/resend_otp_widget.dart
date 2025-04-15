import 'package:flutter/material.dart';

class ResendOtp extends StatelessWidget {
  const ResendOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        // ignore: unused_local_variable
        final double screenHeight = constraints.maxHeight;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't receive code? ",
              style: TextStyle(fontSize: screenWidth * 0.035),
            ),
            GestureDetector(
              onTap: () {
                // print("Resend OTP clicked!");
              },
              child: Text(
                "Re-send",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
