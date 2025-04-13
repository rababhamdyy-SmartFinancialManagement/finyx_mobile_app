import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:finyx_mobile_app/widgets/shared/custom_snack_bar_widget.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

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
            iconColor: Colors.black,
            backgroundColor: Colors.black,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTitleSection(
                    title: "Help & Support",
                    titleColor: Colors.black,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomText(
                    fontSize: 0.035,
                    color: Colors.black,
                    isCentered: true,
                    text:
                        "At Finyx, we're here to help you every step of the way. Whether you're facing a technical issue, need guidance, or have questions about our services — our support team is ready to assist you.\n\n",
                  ),
                  CustomText(
                    fontSize: 0.035,
                    color: Colors.black,
                    isCentered: true,
                    text:
                        "How can we help you?\nYou can reach out to us for:\n\n"
                        "• Troubleshooting app features or bugs\n"
                        "• Account and login issues\n"
                        "• Questions about services and settings\n"
                        "• Feedback and suggestions\n\n",
                  ),
                  CustomText(
                    fontSize: 0.04,
                    color: const Color(0xFF2F80ED),
                    isBold: true,
                    isCentered: true,
                    text: "Contact Us",
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Email tap
                  GestureDetector(
                    onTap: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'finyx.contact@gmail.com',
                        queryParameters: {
                          'subject': 'Finyx Support',
                          'body': 'Hello Finyx Team,',
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
                              const ClipboardData(text: 'finyx.contact@gmail.com'));
                          CustomSnackbar.show(
                            context,
                            'No email app found. Email copied to clipboard.',
                            isError: false,
                          );
                        }
                      } catch (e) {
                        await Clipboard.setData(
                            const ClipboardData(text: 'finyx.contact@gmail.com'));
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
                        const Icon(Icons.email, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          "finyx.contact@gmail.com",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(
                        "Sunday to Thursday | 9 AM - 6 PM",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  CustomText(
                    fontSize: 0.035,
                    color: Colors.black,
                    isCentered: true,
                    text:
                        "Your experience matters to us. We're committed to providing fast, friendly, and helpful support — because your success is our priority.",
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