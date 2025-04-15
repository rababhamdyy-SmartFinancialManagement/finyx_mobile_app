import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // action for FAB
        //print("Floating Action Button Pressed");
      },
      backgroundColor: Colors.yellow[700],
      shape: const CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
        child: Image.asset(
          'assets/images/home/chatAI.png',
        ), 
      ),
    );
  }
}
