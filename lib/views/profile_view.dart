import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("profile"),
        backgroundColor: Color(0xFF261863),
      ),
      body: const Center(
        child: Text(
          'profile screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
