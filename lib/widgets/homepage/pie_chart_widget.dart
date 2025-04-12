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
    final chartSize = screenWidth * 0.58; // النسبة الخاصة بحجم الشارت

    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        double totalPercentage =
            state.sections.fold(0, (sum, section) => sum + section.value);
        double totalBudget =
            userType == UserType.individual ? 1800.00 : 5000.00;
        double availableBudget = (totalPercentage / 100) * totalBudget;

        return Center(
          child: SizedBox(
            width: screenWidth * 0.95,
            height: chartSize + 170, // زيادة المسافة أسفل الشارت
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pie Chart with Animation and Section Space
                Positioned(
                  top: screenHeight * 0.05, // رفع الشارت قليلاً لتناسب مختلف الشاشات
                  child: SizedBox(
                    width: chartSize,
                    height: chartSize,
                    child: PieChart(
                      PieChartData(
                        //animationDuration: Duration(milliseconds: 800), // إضافة الأنيميشن
                        centerSpaceRadius: chartSize * 0.3, // زيادة المسافة في المركز
                        sectionsSpace: 6, // فاصل بين الألوان
                        startDegreeOffset: -90, // مهم جداً لمزامنة الألوان والـ labels
                        sections: state.sections.map((section) {
                          return PieChartSectionData(
                            value: section.value,
                            title: "",
                            color: section.color,
                            radius: chartSize * 0.25,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // Center Data inside the pie chart's white section
                Positioned(
                  top: chartSize * 0.55, // رفع النص والصورة ليكونوا في منتصف الشارت
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/home/Icons.png'),
                        Text(
                          "${availableBudget.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: screenWidth * 0.045),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Available Budget",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // External Labels Positioned Below the Chart with Padding
                Positioned(
                  bottom: 10, // زيادة المسافة بين الشارت والـ labels
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0), // البادينغ من الأسفل فقط
                    child: SizedBox(
                      width: screenWidth * 0.9,
                      child: Wrap(
                        spacing: 16.0,
                        runSpacing: 8.0,
                        children: state.sections.asMap().entries.map((entry) {
                          final index = entry.key;
                          final section = entry.value;

                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Circle Indicator (container)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: section.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8),
                              // Label
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: section.color.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: section.color, width: 1.3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: section.color.withOpacity(0.2),
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
                                    color: Colors.black87,
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
              ],
            ),
          ),
        );
      },
    );
  }

  /// لحساب زاوية منتصف كل جزء من الشارت مع مراعاة البداية من -90 درجة
  double calculateMiddleAngle(List<ChartSection> sections, int index) {
    double total = sections.fold(0, (sum, section) => sum + section.value);
    double startAngle = -90.0; // بالبدايه من الأعلى

    // نحسب الزاوية الابتدائية لكل قسم
    for (int i = 0; i < index; i++) {
      startAngle += (sections[i].value / total) * 360;
    }

    // منتصف الزاوية للقسم الحالي
    double sweepAngle = (sections[index].value / total) * 360;
    double midAngle = startAngle + sweepAngle / 2;

    // نحول من درجة إلى راديان
    return midAngle * math.pi / 180;
  }
}
