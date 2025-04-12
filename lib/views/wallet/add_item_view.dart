import 'package:finyx_mobile_app/widgets/wallet/add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';

// Displays a dialog to add a new item with price
Future<void> showAddItemDialog(BuildContext context) async {
  // Initialize controllers for item name and price input fields
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // Access the PriceCubit to update the prices
  final cubit = context.read<PriceCubit>();

  // Show the dialog with the necessary information
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          // Return the AddDialog widget with controllers, cubit, and current state
          return AddDialog(
            nameController: nameController,
            priceController: priceController,
            cubit: cubit,
            state: state,
          );
        },
      );
    },
  );
}
