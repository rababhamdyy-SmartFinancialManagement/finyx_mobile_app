import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setting"),
        backgroundColor: Color(0xFF261863),
      ),
      body: const Center(
        child: Text(
          'Setting',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
