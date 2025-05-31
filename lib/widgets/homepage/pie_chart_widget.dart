import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/models/chart_section.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/cubits/home/chart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class PieChartWidget extends StatelessWidget {
  final UserType userType;

  const PieChartWidget({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final chartSize = screenWidth * 0.5;
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        return BlocBuilder<PriceCubit, PriceState>(
        builder: (context, priceState) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            double totalSalary = double.tryParse(profileState.salary) ?? 0.00;

            // حساب إجمالي المصروفات المدخلة
            double totalExpenses = priceState.prices.values.fold(
              0.0,
              (sum, value) => sum + value,
            );
            double availableBudget = totalSalary - totalExpenses;
            final isEmpty =
                state.sections.isNotEmpty &&
                state.sections[0].color == Colors.grey[400] &&
                state.sections[0].value == 0;

            return Center(
              child: SizedBox(
                width: screenWidth * 0.95,
                height: chartSize + 230,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pie chart section
                    Positioned(
                      top: screenHeight * 0.05,
                      child: SizedBox(
                        width: chartSize,
                        height: chartSize,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(seconds: 1),
                          builder: (context, value, child) {
                            return PieChart(
                              PieChartData(
                                centerSpaceRadius: chartSize * 0.39,
                                sectionsSpace: 2,
                                startDegreeOffset: -90,
                                sections:
                                    state.sections.map((section) {
                                      return PieChartSectionData(
                                        value: isEmpty ? 1 : section.value,
                                        color: section.color,
                                        radius: chartSize * 0.21,
                                        title:
                                            isEmpty
                                                ? ""
                                                : (section.value > 0
                                                    ? '${section.value.toStringAsFixed(1)}%'
                                                    : ''),
                                        titleStyle: TextStyle(
                                          fontSize: screenWidth * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        showTitle: !isEmpty,
                                      );
                                    }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Salary text section
                    Positioned(
                      top: chartSize * 0.40,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/home/Icons.png',
                              width: screenWidth * 0.1,
                            ),
                            Text(
                              availableBudget.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontFamily: 'Righteous',
                                color: availableBudget < 0 ? Colors.red : null,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              loc.translate("available_balance"),
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey,
                                fontFamily: 'REM',
                              ),
                            ),
                            if (totalExpenses > 0) ...[
                              SizedBox(height: 4),
                              Text(
                                "Total Expenses(${totalExpenses.toStringAsFixed(2)})",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.025,
                                  color: Colors.grey,
                                  fontFamily: 'REM',
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Section labels section
                    Positioned(
                      bottom: 30,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                          width: screenWidth * 0.9,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenWidth * 0.02,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Wrap(
                              spacing: 10.0,
                              runSpacing: 8.0,
                              alignment: WrapAlignment.center,
                              children:
                                  state.sections.map((section) {
                                    return InkWell(
                                      onTap: () {
                                        if (section.title == "Others") {
                                          _showOthersDetails(
                                            context,
                                            state.sections,
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 6,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: section.color.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: section.color,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: screenWidth * 0.025,
                                              height: screenWidth * 0.025,
                                              decoration: BoxDecoration(
                                                color: section.color,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              "${section.title} - ${section.value.toStringAsFixed(1)}%",
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.032,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  });
      }
  }

  void _showOthersDetails(BuildContext context, List<ChartSection> sections) {
    final priceCubit = context.read<PriceCubit>();
    final allPrices = priceCubit.state.prices;
    final othersSection = sections.firstWhere((s) => s.title == "Others");

    // Get categories not included in main sections
    final otherCategories =
        allPrices.keys
            .where(
              (key) =>
                  !sections.any((section) => section.title == key) &&
                  key != "Others",
            )
            .toList();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Other Categories Details"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total percentage: ${othersSection.value.toStringAsFixed(1)}%",
                  ),
                  SizedBox(height: 16),
                  if (otherCategories.isEmpty)
                    Text("No other categories available")
                  else
                    ...otherCategories.map((category) {
                      final value = allPrices[category] ?? 0;
                      final total = allPrices.values.fold(
                        0.0,
                        (sum, val) => sum + val,
                      );
                      final percentage = total > 0 ? (value / total) * 100 : 0;
                      final color = _getColorForCategory(category);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                category,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              "${percentage.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  Color _getColorForCategory(String category) {
    // Use same color generation as in ChartCubit
    final colors = [
      Colors.purple,
      Colors.indigo,
      Colors.pink,
      Colors.teal,
      Colors.deepOrange,
      Colors.blue,
      Colors.green,
      Colors.amber,
    ];
    return colors[category.hashCode % colors.length];
  }

  double calculateMiddleAngle(List<ChartSection> sections, int index) {
    double total = sections.fold(0, (sum, section) => sum + section.value);
    double startAngle = -90.0;

    for (int i = 0; i < index; i++) {
      startAngle += (sections[i].value / total) * 360;
    }

    double sweepAngle = (sections[index].value / total) * 360;
    double midAngle = startAngle + sweepAngle / 2;

    return midAngle * math.pi / 180;
  }
