import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';

class TermsAndConditionsView extends StatefulWidget {
  const TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.025),

                  CustomTitleSection(
                    title: "Terms & Conditions",
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text:
                        "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our app, and other sites we own and operate.\n\n",
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text:
                        "We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.\n\n",
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text:
                        "We only retain collected information for as long as necessary to provide you with your requested service.",
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF2F80ED),
                      ),
                      Expanded(
                        child: Text(
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: const Color(0xFF2F80ED),
                            fontWeight: FontWeight.bold,
                          ),
                          "I agree to the Terms & Conditions",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ButtonWidget(
                    text: "Ok",
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.06,
                    onPressed: () {
                      if (isChecked) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please agree to the Terms & Conditions",
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}