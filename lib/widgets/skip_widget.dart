import 'package:flutter/material.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          "Skip",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            fontFamily: "Righteous",
            color: Color(0xFF8D8D8D),
          ),
        ),
      ),
    );
  }
}
