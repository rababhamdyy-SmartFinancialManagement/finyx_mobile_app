import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceDialog extends StatelessWidget {
  final TextEditingController priceController;
  final PriceCubit cubit;
  final PriceState state;
  final String label;
  final IconData icon;
  final Color iconColor;

  const PriceDialog({
    super.key,
    required this.priceController,
    required this.cubit,
    required this.state,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceCubit, PriceState>(
      // Listens to the state changes in PriceCubit
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white, // Dialog background color
          shape: RoundedRectangleBorder(
            // Rounded corners for the dialog
            borderRadius: BorderRadius.circular(16),
          ),
          title:
              _buildTitle(), // Method to build the title section of the dialog
          content: _buildContent(
            state,
          ), // Method to build the content of the dialog
          actions: _buildActions(context, state), // Buttons for Cancel and Save
        );
      },
    );
  }

  // Builds the title section with an icon and label
  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: iconColor,
            ), // Border color based on iconColor
          ),
          child: Icon(icon, size: 40, color: iconColor), // Display the icon
        ),
        const SizedBox(width: 16),
        Text(
          label, // Display the label (e.g., item name)
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: iconColor, // Text color based on iconColor
          ),
        ),
      ],
    );
  }

  // Builds the content section with a price input field
  Widget _buildContent(PriceState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: priceController, // Bind the controller for input
          decoration: InputDecoration(
            hintText: 'Enter Price', // Placeholder text
            border: OutlineInputBorder(),
            errorText:
                state.showError
                    ? 'Please enter a valid price'
                    : null, // Error handling for invalid input
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: iconColor), // Focused border color
            ),
          ),
          keyboardType:
              TextInputType.number, // Numeric keyboard for price input
        ),
        const SizedBox(height: 16), // Space between input and buttons
      ],
    );
  }

  // Builds the actions (Cancel and Save) buttons
  List<Widget> _buildActions(BuildContext context, PriceState state) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              cubit.setShowError(false); // Hide error message
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'Cancel', // Cancel button text
              style: TextStyle(color: iconColor, fontFamily: "Poppins"),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () async {
              double? price = double.tryParse(
                priceController.text,
              ); // Try to parse the price input
              if (price == null || price <= 0) {
                cubit.setShowError(true); // Show error if input is invalid
                return;
              }

              // Update the price in the cubit state
              cubit.updatePrice(label, price);

              // Save the updated prices in SharedPreferences
              await SharedPrefsHelper.savePrices(cubit.state.prices);

              // Hide error message after successful save
              cubit.setShowError(false);

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text(
              'Save', // Save button text
              style: TextStyle(color: iconColor, fontFamily: "Poppins"),
            ),
          ),
        ],
      ),
    ];
  }
}
