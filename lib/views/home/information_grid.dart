import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/wallet/add_dialog.dart.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/widgets/wallet/price_dialog.dart'; // استيراد PriceDialog

class InformationGrid extends StatelessWidget {
  final UserType userType;

  const InformationGrid({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
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
            {'icon': Icons.flash_on, 'label': 'Electricity'},
            {'icon': Icons.wifi, 'label': 'Internet'},
            {'icon': Icons.fastfood_outlined, 'label': 'Food'},
            {'icon': Icons.money, 'label': 'Zakat'},
            {'icon': Icons.shopping_cart, 'label': 'Shopping'},
            {'icon': Icons.local_gas_station, 'label': 'Gas'},
            {'icon': Icons.water_drop, 'label': 'WaterBill'},
            {'icon': Icons.now_widgets_outlined, 'label': 'More'},
          ]
        : [
            {'icon': Icons.bar_chart, 'label': 'T Revenue'},
            {'icon': Icons.stacked_line_chart, 'label': 'T Expenses'},
            {'icon': Icons.trending_up, 'label': 'Profits'},
            {'icon': Icons.trending_down, 'label': 'Losses'},
            {'icon': Icons.multiple_stop_rounded, 'label': 'Transfer'},
            {'icon': Icons.monetization_on_rounded, 'label': 'E salaries'},
            {'icon': Icons.account_balance_wallet, 'label': 'Loan'},
            {'icon': Icons.now_widgets_outlined, 'label': 'More'},
          ];

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
            return GestureDetector(
              onTap: () {
                if (item['label'] == 'More') {
                  // عند الضغط على العنصر 'More'، نعرض الـ AddDialog
                  _onItemTappedForAddDialog(context);
                } else {
                  // عند الضغط على أي عنصر آخر، نعرض الـ PriceDialog
                  _onItemTappedForPriceDialog(context, item['label'], item['icon'], iconColor);
                }
              },
              child: _buildIconText(
                icon: item['icon'],
                label: item['label'],
                iconColor: iconColor,
                iconSize: iconSize,
                fontSize: fontSize,
              ),
            );
          },
        );
      },
    );
  }

  // عند الضغط على العنصر 'More' نعرض الـ AddDialog
  void _onItemTappedForAddDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    PriceCubit cubit = PriceCubit();
    PriceState state = PriceState(prices: {}); // يمكنك حذف الأسعار هنا

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDialog(
          nameController: nameController,
          priceController: priceController,
          cubit: cubit,
          state: state,
        );
      },
    );
  }

  // عند الضغط على أي عنصر آخر نعرض الـ PriceDialog
  void _onItemTappedForPriceDialog(BuildContext context, String label, IconData icon, Color iconColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PriceDialog(
          priceController: TextEditingController(),
          cubit: PriceCubit(),
          state: PriceState(prices: {}), // يمكنك حذف الأسعار هنا أيضًا
          label: label,
          icon: icon,
          iconColor: iconColor,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
