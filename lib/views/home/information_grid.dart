import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/wallet/add_dialog.dart';
import 'package:finyx_mobile_app/widgets/wallet/price_dialog.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';

class InformationGrid extends StatelessWidget {
  final UserType userType;

  const InformationGrid({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PriceCubit>();
    final loc = AppLocalizations.of(context)!;

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

    List<Map<String, dynamic>> items =
        userType == UserType.individual
            ? [
              {
                'icon': Icons.flash_on,
                'label': 'electricity',
                'translated': loc.translate("electricity"),
              },
              {
                'icon': Icons.wifi,
                'label': 'internet',
                'translated': loc.translate("internet"),
              },
              {
                'icon': Icons.fastfood_outlined,
                'label': 'food',
                'translated': loc.translate("food"),
              },
              {
                'icon': Icons.money,
                'label': 'zakat',
                'translated': loc.translate("zakat"),
              },
              {
                'icon': Icons.shopping_cart,
                'label': 'shopping',
                'translated': loc.translate("shopping"),
              },
              {
                'icon': Icons.local_gas_station,
                'label': 'gas',
                'translated': loc.translate("gas"),
              },
              {
                'icon': Icons.water_drop,
                'label': 'waterBill',
                'translated': loc.translate("waterBill"),
              },
              {
                'icon': Icons.now_widgets_outlined,
                'label': 'more',
                'translated': loc.translate("more"),
              },
            ]
            : [
              {
                'icon': Icons.bar_chart,
                'label': 'tRevenue',
                'translated': loc.translate("tRevenue"),
              },
              {
                'icon': Icons.stacked_line_chart,
                'label': 'tExpenses',
                'translated': loc.translate("tExpenses"),
              },
              {
                'icon': Icons.trending_up,
                'label': 'profits',
                'translated': loc.translate("profits"),
              },
              {
                'icon': Icons.trending_down,
                'label': 'losses',
                'translated': loc.translate("losses"),
              },
              {
                'icon': Icons.multiple_stop_rounded,
                'label': 'transfer',
                'translated': loc.translate("transfer"),
              },
              {
                'icon': Icons.monetization_on_rounded,
                'label': 'eSalaries',
                'translated': loc.translate("eSalaries"),
              },
              {
                'icon': Icons.account_balance_wallet,
                'label': 'loan',
                'translated': loc.translate("loan"),
              },
              {
                'icon': Icons.now_widgets_outlined,
                'label': 'more',
                'translated': loc.translate("more"),
              },
            ];

    return BlocBuilder<PriceCubit, PriceState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double iconSize = constraints.maxWidth / 8;
            double fontSize = constraints.maxWidth / 27;

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                final iconColor = iconColors[index % iconColors.length];
                final label = item['label'] as String;
                final icon = item['icon'] as IconData;

                return GestureDetector(
                  onTap: () async {
                    if (label == loc.translate("more")) {
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
                              label: item['label'],
                              icon: icon,
                              iconColor: iconColor,
                            ),
                      );
                    }
                  },
                  child: _buildIconText(
                    icon: icon,
                    label: item['translated'],
                    iconColor: iconColor,
                    iconSize: iconSize,
                    fontSize: fontSize,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildIconText({
    required IconData icon,
    required String label,
    required Color iconColor,
    required double iconSize,
    required double fontSize,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: iconSize * 0.6),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
