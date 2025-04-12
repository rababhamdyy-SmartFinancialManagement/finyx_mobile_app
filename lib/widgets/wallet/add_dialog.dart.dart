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
    Color iconColor = Color(0xFF3E0555);

    return BlocBuilder<PriceCubit, PriceState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: iconColor),
                ),
                child: Icon(Icons.add, size: 40, color: iconColor),
              ),
              const SizedBox(width: 16),
              Text(
                'Add New Item',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: iconColor,
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
                    borderSide: BorderSide(color: iconColor),
                  ),
                  errorText: state.showError ? 'Please enter a name' : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Price',
                  border: OutlineInputBorder(),
                  errorText: state.showError ? 'Enter valid price' : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor),
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
                    cubit.setShowError(false);
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: iconColor, fontFamily: 'Poppins')),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final price = double.tryParse(priceController.text.trim());

                    if (name.isEmpty || price == null || price <= 0) {
                      cubit.setShowError(true);
                      return;
                    }

                    cubit.updatePrice(name, price,);
                    await SharedPrefsHelper.setDialogShown(name, true);
                    cubit.setShowError(false);
                    Navigator.of(context).pop();
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
