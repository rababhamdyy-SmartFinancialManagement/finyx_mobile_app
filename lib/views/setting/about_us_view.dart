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
                    title: "About Us",
                    titleColor: Colors.black,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.001),
                  CustomText(
                    fontSize: 0.035,
                    color: Colors.black,
                    isCentered: true,
                    text:
                        "Finyx is a cutting-edge platform that aims to empower individuals and businesses by providing innovative solutions to everyday challenges. We offer a wide range of tools and services designed to make life easier, more efficient, and more enjoyable for our users. Our commitment is to offer high-quality, user-centric experiences tailored to meet the unique needs of each individual.\n\n",
                  ),
                  CustomText(
                    fontSize: 0.035,
                    color: Colors.black,
                    isCentered: true,
                    text:
                        "Our goal is to bridge gaps in the digital landscape by providing solutions that are not only accessible but also intuitive and reliable. Whether you're a student, professional, or business owner, Finyx strives to create value through seamless digital experiences.\n\n",
                  ),
                  CustomText(
                    fontSize: 0.035,
                    color: Colors.black,
                    isCentered: true,
                    text:
                        "At Finyx, we prioritize customer satisfaction and focus on delivering solutions that help people achieve their personal and professional goals. We understand the challenges faced by our users, and we are dedicated to providing them with the best possible tools to succeed. We continuously innovate and improve to stay ahead in a rapidly evolving digital world.\n\n",
                  ),
                  CustomText(
                    fontSize: 0.045,
                    color: Colors.black,
                    isCentered: true,
                    isBold: true,
                    text: "Our Vision",
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  CustomText(
                    fontSize: 0.035,
                    color: Colors.black,
                    isCentered: true,
                    text:
                        "We envision a future where technology enhances the lives of everyone, making tasks simpler, more connected, and more efficient. Our goal is to build a platform that becomes the go-to solution for all digital needs, promoting growth, sustainability, and a better quality of life for all users.",
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