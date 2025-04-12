import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/wallet/wallet_body.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  final UserType userType;
  
  // Constructor to receive the user type (Individual or Business)
  const WalletScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    // Return the scaffold containing the app bar and the body of the wallet screen
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Bill', // Title displayed in the app bar
          style: TextStyle(fontFamily: 'Righteous', fontSize: 25), // Text style for the title
        ),
      ),
      body: WalletBody(userType: userType), // Pass the user type to the WalletBody to display appropriate content
    );
  }
}