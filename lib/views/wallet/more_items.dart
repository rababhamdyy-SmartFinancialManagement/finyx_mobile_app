import 'package:finyx_mobile_app/widgets/wallet/add_dialog.dart';
import 'package:finyx_mobile_app/widgets/wallet/price_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';

// Displays the "More Items" dialog, with content varying based on user type
Future<void> moreItems(BuildContext context, UserType userType) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          return MoreItems(
            state: state,
            userType: userType,
          ); // Pass userType to MoreItems widget
        },
      );
    },
  );
}

// Widget to display the "More Items" dialog with different options based on user type
class MoreItems extends StatelessWidget {
  final PriceState state;
  final UserType userType;

  const MoreItems({super.key, required this.state, required this.userType});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final cubit = context.read<PriceCubit>(); // Access the PriceCubit

    // List of icon colors for the items
    List<Color> iconColors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.grey,
    ];

    // Icons for individual users
    List<IconData> individualIcons = [
      Icons.sports_tennis_rounded,
      Icons.phone_iphone,
      Icons.car_repair,
      Icons.wallet,
      Icons.medical_services_outlined,
      Icons.movie_filter_outlined,
      Icons.groups_outlined,
      Icons.now_widgets_outlined,
    ];

    // Icons for business users
    List<IconData> businessIcons = [
      Icons.assignment, // Licenses
      Icons.money_off, // Accrued interest
      Icons.account_balance_wallet, // Administrative expenses
      Icons.flash_on, // Electricity
      Icons.wifi, // Internet
      Icons.local_shipping,
      Icons.monetization_on, // Zakat
      Icons.now_widgets_outlined, // More
    ];

    // Names for individual users
    List<String> individualNames = [
      'Club',
      'Mobile Credit',
      'Car',
      'Voucher',
      'Assurance',
      'Cinema',
      'Association',
      'More',
    ];

    // Names for business users
    List<String> businessNames = [
      'Licenses',
      'Accrued Interest',
      'Admin Expenses',
      'Electricity',
      'Internet',
      'Shipping',
      'Zakat',
      'More',
    ];

    // Choose the appropriate icons and names based on the user type
    List<IconData> icons =
        userType == UserType.business ? businessIcons : individualIcons;
    List<String> itemNames =
        userType == UserType.business ? businessNames : individualNames;

    return AlertDialog(
      backgroundColor: theme.dialogBackgroundColor, 

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(
        child: Text(
          'Add New Bill',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      content: Container(
        width: double.maxFinite,
        child: Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          alignment: WrapAlignment.center,
          children: List.generate(8, (index) {
            final color = iconColors[index % iconColors.length];
            final label = itemNames[index];
            final icon = icons[index];

            return GestureDetector(
              onTap: () async {
                Navigator.of(context).pop(); // Close the dialog first

                // Show the appropriate dialog based on the selected item
                if (label == 'More' || label == 'More Business') {
                  await showDialog(
                    context: context,
                    builder:
                        (_) => AddDialog(
                          nameController: TextEditingController(),
                          priceController: TextEditingController(),
                          cubit: cubit,
                          state: state,
                        ),
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder:
                        (_) => PriceDialog(
                          priceController: TextEditingController(),
                          cubit: cubit,
                          state: state,
                          label: label,
                          icon: icon,
                          iconColor: color,
                        ),
                  );
                }
              },
              child: SizedBox(
                width: 90,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color.withAlpha(15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: color, width: 1.5),
                      ),
                      child: Icon(icon, color: color, size: 28),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
