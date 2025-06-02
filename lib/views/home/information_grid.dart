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

    List<Map<String, dynamic>> getDefaultItems() {
      if (userType == UserType.individual) {
        return [
          {'icon': Icons.flash_on, 'label': 'electricity'},
          {'icon': Icons.wifi, 'label': 'internet'},
          {'icon': Icons.fastfood_outlined, 'label': 'food'},
          {'icon': Icons.money, 'label': 'zakat'},
          {'icon': Icons.shopping_cart, 'label': 'shopping'},
          {'icon': Icons.local_gas_station, 'label': 'gas'},
          {'icon': Icons.water_drop, 'label': 'waterBill'},
          {'icon': Icons.now_widgets_outlined, 'label': 'more'},
        ];
      } else {
        return [
          {'icon': Icons.bar_chart, 'label': 'tRevenue'},
          {'icon': Icons.stacked_line_chart, 'label': 'tExpenses'},
          {'icon': Icons.trending_up, 'label': 'profits'},
          {'icon': Icons.trending_down, 'label': 'losses'},
          {'icon': Icons.multiple_stop_rounded, 'label': 'transfer'},
          {'icon': Icons.monetization_on_rounded, 'label': 'eSalaries'},
          {'icon': Icons.account_balance_wallet, 'label': 'loan'},
          {'icon': Icons.now_widgets_outlined, 'label': 'more'},
        ];
      }
    }

    String _getTranslatedLabel(String originalLabel) {
      return loc.translate(originalLabel) ?? originalLabel;
    }

    return BlocBuilder<PriceCubit, PriceState>(
      builder: (context, state) {
        final defaultItems = getDefaultItems();
        
        return LayoutBuilder(
          builder: (context, constraints) {
            double iconSize = constraints.maxWidth / 8;
            double fontSize = constraints.maxWidth / 27;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: defaultItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final item = defaultItems[index];
                final originalLabel = item['label'] as String;
                final label = _getTranslatedLabel(originalLabel);
                final icon = item['icon'] as IconData;
                final iconColor = iconColors[index % iconColors.length];

                return GestureDetector(
                  onTap: () async {
                    if (originalLabel == 'more') {
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
                          label: originalLabel,
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