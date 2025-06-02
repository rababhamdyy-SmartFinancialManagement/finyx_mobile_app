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

    List<Map<String, dynamic>> items = userType == UserType.individual
        ? [
            {'icon': Icons.flash_on, 'label': loc.translate("electricity")},
            {'icon': Icons.wifi, 'label': loc.translate("internet")},
            {'icon': Icons.fastfood_outlined, 'label': loc.translate("food")},
            {'icon': Icons.money, 'label': loc.translate("zakat")},
            {'icon': Icons.shopping_cart, 'label': loc.translate("shopping")},
            {'icon': Icons.local_gas_station, 'label': loc.translate("gas")},
            {'icon': Icons.water_drop, 'label': loc.translate("waterBill")},
            {'icon': Icons.now_widgets_outlined, 'label': loc.translate("more")},
          ]
        : [
            {'icon': Icons.bar_chart, 'label': loc.translate("tRevenue")},
            {'icon': Icons.stacked_line_chart, 'label': loc.translate("tExpenses")},
            {'icon': Icons.trending_up, 'label': loc.translate("profits")},
            {'icon': Icons.trending_down, 'label': loc.translate("losses")},
            {'icon': Icons.multiple_stop_rounded, 'label': loc.translate("transfer")},
            {'icon': Icons.monetization_on_rounded, 'label': loc.translate("eSalaries")},
               {'icon': Icons.account_balance_wallet, 'label': loc.translate("loan")},
            {'icon': Icons.now_widgets_outlined, 'label': loc.translate("more")},
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
                        builder: (_) => AddDialog(
                          nameController: TextEditingController(),
                          priceController: TextEditingController(),
                          cubit: cubit,
                          state: state,
                        ),
                      );
                    } else {
                      await showDialog(
                        context: context,
                        builder: (_) => PriceDialog(
                          priceController: TextEditingController(),
                          cubit: cubit,
                          state: state,
                          label: label,
                          icon: icon,
                          iconColor: iconColor,
                        ),
                      );
                    }
                  },
                  child: _buildIconText(
                    icon: icon,
                    label: label,
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
