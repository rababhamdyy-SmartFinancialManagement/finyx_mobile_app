import 'package:flutter/material.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(8, 32, 0, 0), 
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            "Skip",
            style: TextStyle(
              fontSize: screenWidth > 600 ? 24 : 28, 
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
