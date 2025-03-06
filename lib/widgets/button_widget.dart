import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Size size;
  const ButtonWidget({super.key, required this.text,required this.size});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF3E0555),
        fixedSize: size,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Color(0xFF000000).withAlpha(40),
        elevation: 10,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontFamily: "Righteous",
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
