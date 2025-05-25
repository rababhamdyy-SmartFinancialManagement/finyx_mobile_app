import 'package:flutter/material.dart';

class WalletListTile extends StatelessWidget {
  final IconData icon; // Icon to be displayed for the list item
  final String label; // Label for the item (e.g., "Electricity")
  final double? price; // Price associated with the item
  final BuildContext context; // The context in which the widget is used
  final VoidCallback onTap; // Callback function when the tile is tapped
  final bool isDeletable; // Flag to determine if the item is deletable
  final Color backgroundColor; // Background color of the tile
  final Color iconColor; // Color for the icon

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
    final ThemeData theme = Theme.of(context);
    final Color trailingBackgroundColor =
        theme.brightness == Brightness.dark
            ? theme
                .cardColor // Get the background color from the theme for dark mode
            : Colors.white; // Use white for light mode

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: backgroundColor, // Set the background color of the tile
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: _buildLeadingIcon(),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
        ),
        trailing: _buildTrailingButton(trailingBackgroundColor),
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

  Widget _buildTrailingButton(Color trailingBackgroundColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: trailingBackgroundColor, // Use background color based on theme
          border: Border.all(color: iconColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          price != null ? 'EGP $price/month' : 'Enter Price',
          style: const TextStyle(fontSize: 14, fontFamily: "Poppins"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
