import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int selectedIndex;

  const Indicator({required this.selectedIndex, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double indicatorWidth = screenWidth > 600 ? 24 : 20;
    double indicatorHeight = screenWidth > 600 ? 5 : 4.5;
    double margin = screenWidth > 600 ? 8 : 5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/onboardingScreen', arguments: index);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: margin),
            width: indicatorWidth,
            height: indicatorHeight,
            decoration: BoxDecoration(
              color: index == selectedIndex ? Colors.black : Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
      ),
    );
  }
}
