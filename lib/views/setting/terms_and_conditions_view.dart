import 'package:finyx_mobile_app/models/applocalization.dart';
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
                  SizedBox(height: screenHeight * 0.025),
                  CustomTitleSection(
                    title: loc.translate("Terms_Conditions"),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Terms_Conditions_Paragraph_1"),
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Terms_Conditions_Paragraph_2"),
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Terms_Conditions_Paragraph_3"),
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
                          loc.translate("Agree_Terms_Conditions"),
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
                              loc.translate("Terms_Conditions_Alert"),
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
