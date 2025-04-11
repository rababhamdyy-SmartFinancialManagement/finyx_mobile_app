import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/home/balance_card.dart';
import 'package:finyx_mobile_app/views/home/information_grid.dart';
import 'package:finyx_mobile_app/widgets/homepage/pie_chart_widget.dart';
import 'package:flutter/material.dart';

class HomepageBody extends StatelessWidget {
  final UserType userType;

  const HomepageBody({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final chartSize = screenWidth * 0.6;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Yennefer Doe,",
              style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              "Your available balance",
              style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
            ),
            SizedBox(height: screenWidth * 0.04),

            BalanceCard(),
            SizedBox(height: screenWidth * 0.06),
            PieChartWidget(chartSize: chartSize, userType: userType),
            SizedBox(height: screenWidth * 0.02),

            Center(
              child: Text(
                "₹1800.00\nAvailable Budget",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: screenWidth * 0.06),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Information List",
                  style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                ),
                Text(
                  "View",
                  style: TextStyle(color: Colors.deepPurple, fontSize: screenWidth * 0.04),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04),
            InformationGrid(userType: userType),
          ],
        ),
      ),
    );
  }
}
