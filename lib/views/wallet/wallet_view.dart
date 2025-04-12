import 'package:finyx_mobile_app/views/wallet/wallet_body.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Bill',
          style: TextStyle(fontFamily: 'Righteous', fontSize: 25),
        ),
      ),
      body: WalletBody(),
    );
  }
}
