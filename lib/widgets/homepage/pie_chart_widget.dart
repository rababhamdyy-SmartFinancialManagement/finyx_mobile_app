import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
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
    final chartSize = screenWidth * 0.58;

    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        double totalPercentage = state.sections.fold(
          0,
          (sum, section) => sum + section.value,
        );
        double totalBudget =
            userType == UserType.individual ? 1800.00 : 5000.00;
        double availableBudget = (totalPercentage / 100) * totalBudget;

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
                            centerSpaceRadius: chartSize * 0.3,
                            sectionsSpace: 6,
                            startDegreeOffset: -70,
                            sections:
                                state.sections.map((section) {
                                  return PieChartSectionData(
                                    value: section.value * value,
                                    title: "",
                                    color: section.color,
                                    radius: chartSize * 0.25,
                                  );
                                }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Budget text section
                Positioned(
                  top: chartSize * 0.55,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/home/Icons.png'),
                        Text(
                          "${availableBudget.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'Righteous',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Available Budget",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey,
                            fontFamily: 'REM',
                          ),
                        ),
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
                          spacing: 20.0,
                          runSpacing: 8.0,
                          children:
                              state.sections.asMap().entries.map((entry) {
                                final index = entry.key;
                                final section = entry.value;

                                return Row(
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
                                    SizedBox(width: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03,
                                        vertical: screenWidth * 0.015,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: section.color,
                                          width: 1.3,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: section.color.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "${section.title} - ${section.value.toInt()}%",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.034,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
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
  }

  double calculateMiddleAngle(List<ChartSection> sections, int index) {
    double total = sections.fold(0, (sum, section) => sum + section.value);
    double startAngle = -70.0;

    for (int i = 0; i < index; i++) {
      startAngle += (sections[i].value / total) * 360;
    }

    double sweepAngle = (sections[index].value / total) * 360;
    double midAngle = startAngle + sweepAngle / 2;

    return midAngle * math.pi / 180;
  }
}
