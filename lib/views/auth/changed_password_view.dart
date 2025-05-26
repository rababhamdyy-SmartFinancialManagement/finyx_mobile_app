import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/shared/greeting_widget.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/models/password_changed_model.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';

class PasswordChangedView extends StatelessWidget {
  final PasswordChangedModel _model = PasswordChangedModel();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/otp/sucess.png",
                width: screenWidth * 0.7,
                height: screenHeight * 0.3,
                fit: BoxFit.contain,
              ),
              SizedBox(height: screenHeight * 0.02),
              GreetingWidget(
                greetingText: loc.translate("password_changed_title"),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                loc.translate("password_changed_message"),
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.05),
              ButtonWidget(
                text: loc.translate("go_to_login"),
                width: screenWidth * 0.7,
                height: screenHeight * 0.06,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
