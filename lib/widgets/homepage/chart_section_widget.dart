import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/chart_section.dart';

class ChartSectionWidget extends StatelessWidget {
  final ChartSection section;

  const ChartSectionWidget({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: section.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.white, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(section.title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text("${section.value}%"),
        ],
      ),
    );
  }
}
