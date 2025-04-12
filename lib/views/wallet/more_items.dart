import 'package:finyx_mobile_app/widgets/wallet/add_dialog.dart.dart';
import 'package:finyx_mobile_app/widgets/wallet/price_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';

Future<void> moreItems(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          return MoreItems(state: state);
        },
      );
    },
  );
}

class MoreItems extends StatelessWidget {
  final PriceState state;
  const MoreItems({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PriceCubit>();

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

    List<IconData> icons = [
      Icons.sports_tennis_rounded,
      Icons.phone_iphone,
      Icons.car_repair,
      Icons.shopping_cart,
      Icons.medical_services_outlined,
      Icons.movie_filter_outlined,
      Icons.groups_outlined,
      Icons.now_widgets_outlined,
    ];

    List<String> itemNames = [
      'Club',
      'Mobile Credit',
      'Car',
      'Voucher',
      'Assurance',
      'Cinema',
      'Association',
      'More',
    ];

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(
        child: Text(
          'Add New Bill',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: Colors.black,
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
                Navigator.of(context).pop(); // close this dialog first
                if (label == 'More') {
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
                        color: Colors.black,
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
