import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final PriceCubit cubit;
  final PriceState state;

  const AddDialog({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = Color(0xFF3E0555); // Color for the dialog icon and text

    return BlocBuilder<PriceCubit, PriceState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Rounded corners for the dialog
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: iconColor), // Border color for the icon container
                ),
                child: Icon(Icons.add, size: 40, color: iconColor), // Add icon
              ),
              const SizedBox(width: 16),
              Text(
                'Add New Item',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: iconColor, // Text color for the title
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Item Name',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor), // Border color when focused
                  ),
                  errorText: state.showError ? 'Please enter a name' : null, // Display error message if needed
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Price',
                  border: OutlineInputBorder(),
                  errorText: state.showError ? 'Enter valid price' : null, // Display error message if needed
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor), // Border color when focused
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    cubit.setShowError(false); // Hide error state
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel', style: TextStyle(color: iconColor, fontFamily: 'Poppins')),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    final name = nameController.text.trim(); // Get trimmed name input
                    final price = double.tryParse(priceController.text.trim()); // Parse price input

                    // Validate inputs: name should not be empty, and price should be valid and greater than 0
                    if (name.isEmpty || price == null || price <= 0) {
                      cubit.setShowError(true); // Set error state to true
                      return;
                    }

                    cubit.updatePrice(name, price); // Update the price using the cubit
                    await SharedPrefsHelper.setDialogShown(name, true); // Mark that the dialog has been shown for the item
                    cubit.setShowError(false); // Hide error state
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Save', style: TextStyle(color: iconColor, fontFamily: "Poppins")),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
