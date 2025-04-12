import 'package:flutter/material.dart';

class WalletBody extends StatelessWidget {
  const WalletBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to Wallet Body!',
        style: TextStyle(fontSize: 24, color: Colors.yellow[700]),
      ),
    );
  }
}
