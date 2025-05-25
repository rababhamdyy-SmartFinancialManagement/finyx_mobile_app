import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
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
                    title: loc.translate("About_Us"), // من localization
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.001),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("About_Us_Paragraph_1"),
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("About_Us_Paragraph_2"),
                  ),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("About_Us_Paragraph_3"),
                  ),
                  CustomText(
                    fontSize: 0.045,
                    isCentered: true,
                    isBold: true,
                    text: loc.translate("Our_Vision"),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Our_Vision_Paragraph"),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
