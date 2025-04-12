import 'package:flutter/material.dart';

class WalletListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final double? price;
  final BuildContext context;
  final VoidCallback onTap;
  final bool isDeletable;
  final Color backgroundColor;
  final Color iconColor;

  const WalletListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.price,
    required this.context,
    required this.onTap,
    required this.isDeletable,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: _buildLeadingIcon(),
        title: Text(label, style: const TextStyle(fontSize: 16,fontFamily: "Poppins")),
        trailing: _buildTrailingButton(),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor),
      ),
      child: Icon(icon, size: 30, color: iconColor),
    );
  }

  Widget _buildTrailingButton() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: iconColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          price != null ? 'EGP $price/month' : 'Enter Price',
          style: const TextStyle(fontSize: 14,fontFamily: "Poppins"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
