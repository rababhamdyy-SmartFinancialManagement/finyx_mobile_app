import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int selectedIndex;

  const Indicator({
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: 20,
          height: 4.5,
          decoration: BoxDecoration(
            color: index == selectedIndex ? Colors.black : Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ),
    );
  }
}
