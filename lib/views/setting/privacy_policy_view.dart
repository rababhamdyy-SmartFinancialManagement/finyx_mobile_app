import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                  CustomTitleSection(
                    title: loc.translate("Privacy_Policy"),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.015),

                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Privacy_Policy_Paragraph_1"),
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Privacy_Policy_Paragraph_2"),
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Privacy_Policy_Paragraph_3"),
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Privacy_Policy_Paragraph_4"),
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
                          loc.translate("Agree_Privacy_Policy"),
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: const Color(0xFF2F80ED),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  ButtonWidget(
                    text: loc.translate("Ok_Button"),
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.06,
                    onPressed: () {
                      if (isChecked) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              loc.translate("Privacy_Policy_Alert"),
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
