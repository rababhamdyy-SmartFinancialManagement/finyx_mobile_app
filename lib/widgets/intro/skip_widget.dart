import 'package:flutter/material.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.05, 0), 
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            "Skip",
            style: TextStyle(
              fontSize: screenWidth > 600 ? 28 : 24, 
              fontWeight: FontWeight.w400,
              fontFamily: "Righteous",
              color: Color(0xFF8D8D8D),
            ),
          ),
        ),
      ),
    );
  }
}
