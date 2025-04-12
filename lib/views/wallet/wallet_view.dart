import 'package:finyx_mobile_app/views/wallet/wallet_body_view.dart';
import 'package:finyx_mobile_app/widgets/homepage/custom_floating_action_button.dart';
import 'package:finyx_mobile_app/widgets/homepage/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: const WalletBody());
  }
}
