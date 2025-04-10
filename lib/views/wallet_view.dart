import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        backgroundColor: Color(0xFF261863),
      ),
      body: const Center(
        child: Text(
          'wallet',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
