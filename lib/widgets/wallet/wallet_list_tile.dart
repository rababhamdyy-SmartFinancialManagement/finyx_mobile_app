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
    return Padding(
      padding: const EdgeInsets.all(8.0), // Padding around the ListTile
      child: ListTile(
        tileColor: backgroundColor, // Set the background color of the tile
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Rounded corners for the tile
        leading: _buildLeadingIcon(), // Widget for leading icon
        title: Text(
          label, // Display the label of the item
          style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
        ),
        trailing: _buildTrailingButton(), // Widget for the trailing button (price or 'Enter Price')
      ),
    );
  }

  // Method to build the leading icon (on the left side of the tile)
  Widget _buildLeadingIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background for the icon
        borderRadius: BorderRadius.circular(16), // Rounded corners
        border: Border.all(color: iconColor), // Border color for the icon
      ),
      child: Icon(icon, size: 30, color: iconColor), // Display the icon with specified size and color
    );
  }

  // Method to build the trailing button (on the right side of the tile)
  Widget _buildTrailingButton() {
    return GestureDetector(
      onTap: onTap, // Execute the onTap callback when the button is tapped
      child: Container(
        width: 140, // Set a fixed width for the button
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white, // White background for the button
          border: Border.all(color: iconColor), // Border color for the button
          borderRadius: BorderRadius.circular(8), // Rounded corners for the button
        ),
        child: Text(
          price != null ? 'EGP $price/month' : 'Enter Price', // Display price if available, otherwise prompt to enter price
          style: const TextStyle(fontSize: 14, fontFamily: "Poppins"),
          textAlign: TextAlign.center, // Center the text within the button
        ),
      ),
    );
  }
}
