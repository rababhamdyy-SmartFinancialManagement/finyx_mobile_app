import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
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
                    title: loc.translate("Help_Support"),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Paragraph 1
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Help_Support_Paragraph_1"),
                  ),

                  // Paragraph 2
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Help_Support_Paragraph_2"),
                  ),

                  // Contact Us title
                  Text(
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2F80ED),
                    ),
                    loc.translate("Contact_Us"),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Email tap
                  GestureDetector(
                    onTap: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: loc.translate("Email_Address"),
                        queryParameters: {
                          'subject': 'Finyx_Support',
                          'body': 'Hello,Finyx_Team,',
                        },
                      );

                      try {
                        bool canOpen = await canLaunchUrl(emailUri);
                        if (canOpen) {
                          await launchUrl(
                            emailUri,
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        } else {
                          // Fallback: Copy email to clipboard
                          await Clipboard.setData(
                            ClipboardData(text: loc.translate("Email_Address")),
                          );
                          CustomSnackbar.show(
                            context,
                            'No email app found. Email copied to clipboard.',
                            isError: false,
                          );
                        }
                      } catch (e) {
                        await Clipboard.setData(
                          ClipboardData(text: loc.translate("Email_Address")),
                        );
                        CustomSnackbar.show(
                          context,
                          'Error: ${e.toString()}. Email copied to clipboard.',
                          isError: true,
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 8),
                        Text(
                          loc.translate("Email_Address"),
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Working Hours
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      Text(
                        loc.translate("Working_Hours"),
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Paragraph 3
                  CustomText(
                    fontSize: 0.035,
                    isCentered: true,
                    text: loc.translate("Help_Support_Paragraph_3"),
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
