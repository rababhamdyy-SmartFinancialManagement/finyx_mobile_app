import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/wallet/wallet_body.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  final UserType userType;
  const WalletScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    // تحديد نوع المستخدم، سواء كان فردي أو بيزنيس

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Bill',
          style: TextStyle(fontFamily: 'Righteous', fontSize: 25),
        ),
      ),
      body: WalletBody(userType: userType), // تمرير UserType هنا
    );
  }
}
