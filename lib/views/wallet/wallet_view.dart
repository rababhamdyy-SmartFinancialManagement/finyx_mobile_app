import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/wallet/wallet_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatelessWidget {
  final UserType userType;

  // Constructor to receive the user type (Individual or Business)
  const WalletScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Return the scaffold containing the app bar and the body of the wallet screen
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          loc.translate("viewBill"),
          style: TextStyle(fontFamily: 'Righteous', fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: WalletBody(
        userType: userType,
      ), // Pass the user type to the WalletBody to display appropriate content
    );
  }
}
