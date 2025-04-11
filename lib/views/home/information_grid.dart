import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter/material.dart';

class InformationGrid extends StatelessWidget {
  final UserType userType;

  const InformationGrid({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = userType == UserType.individual
        ? [
            {'icon': Icons.flash_on, 'label': 'Electricity'},
            {'icon': Icons.wifi, 'label': 'Internet'},
            {'icon': Icons.fastfood, 'label': 'Food'},
            {'icon': Icons.money, 'label': 'Zakat'},
            {'icon': Icons.shopping_cart, 'label': 'Shopping'},
            {'icon': Icons.local_gas_station, 'label': 'Gas'},
            {'icon': Icons.water_drop, 'label': 'WaterBill'},
            {'icon': Icons.more_horiz, 'label': 'More'},
          ]
        : [
            {'icon': Icons.bar_chart, 'label': 'Total Revenue'},
            {'icon': Icons.stacked_line_chart, 'label': 'Total Expenses'},
            {'icon': Icons.trending_up, 'label': 'Profits'},
            {'icon': Icons.trending_down, 'label': 'Losses'},
            {'icon': Icons.send, 'label': 'Transfer money'},
            {'icon': Icons.attach_money, 'label': 'Employee salaries'},
            {'icon': Icons.account_balance_wallet, 'label': 'Loan'},
            {'icon': Icons.more_horiz, 'label': 'More'},
          ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 0.8,
      children: items
          .map((item) => _buildIconText(item['icon'] as IconData, item['label'] as String))
          .toList(),
    );
  }

  Widget _buildIconText(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.deepPurple),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
