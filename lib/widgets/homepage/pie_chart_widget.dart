import 'dart:math' as math;

import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/models/chart_section.dart';
import 'package:finyx_mobile_app/views/wallet/more_items.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/home/chart_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PieChartWidget extends StatelessWidget {
  final UserType userType;

  const PieChartWidget({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final chartSize = screenWidth * 0.5;
    final loc = AppLocalizations.of(context)!;
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'default_user';

    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        return BlocBuilder<PriceCubit, PriceState>(
          builder: (context, priceState) {
            return BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, profileState) {
                double totalSalary =
                    double.tryParse(profileState.salary) ?? 0.00;
                double totalExpenses = priceState.prices.values.fold(
                  0.0,
                  (sum, value) => sum + value,
                );
                double availableBudget = totalSalary - totalExpenses;
                final isEmpty = state.sections.every((s) => s.value == 0);

                return Center(
                  child: SizedBox(
                    width: screenWidth * 0.95,
                    height: chartSize + 230,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: screenHeight * 0.05,
                          child: SizedBox(
                            width: chartSize,
                            height: chartSize,
                            child: PieChart(
                              PieChartData(
                                centerSpaceRadius: chartSize * 0.39,
                                sectionsSpace: 2,
                                startDegreeOffset: -90,
                                sections:
                                    isEmpty
                                        ? [
                                          PieChartSectionData(
                                            value: 100,
                                            color: Colors.grey[400]!,
                                            radius: chartSize * 0.21,
                                            showTitle: false,
                                          ),
                                        ]
                                        : state.sections
                                            .map(
                                              (s) => PieChartSectionData(
                                                value: s.value,
                                                color: s.color,
                                                radius: chartSize * 0.21,
                                                title:
                                                    isEmpty
                                                        ? ""
                                                        : (s.value > 0
                                                            ? '${s.value.toStringAsFixed(1)}%'
                                                            : ''),

                                                titleStyle: TextStyle(
                                                  fontSize: screenWidth * 0.03,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                showTitle: s.value > 0,
                                              ),
                                            )
                                            .toList(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: chartSize * 0.40,
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
                                  color:
                                      availableBudget < 0 ? Colors.red : null,
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
                                  "${loc.translate("total_expenses")} (${totalExpenses.toStringAsFixed(2)})",
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
                        Positioned(
                          bottom: 30,
                          child: SizedBox(
                            width: screenWidth * 0.9,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenWidth * 0.02,
                              ),
                              child: Wrap(
                                spacing: 10.0,
                                runSpacing: 8.0,
                                alignment: WrapAlignment.center,
                                children:
                                    state.sections
                                        .map(
                                          (s) => InkWell(
                                            onTap:
                                                () =>
                                                    s.title == "Others"
                                                        ? _showOthersDetails(
                                                          context,
                                                          state.sections,
                                                        )
                                                        : null,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 6,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: s.color.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: s.color,
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
                                                      color: s.color,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  FutureBuilder<String>(
                                                    future: translateSmart(
                                                      s.title,
                                                      loc,
                                                      loc.locale!.languageCode,
                                                    ),
                                                    builder: (
                                                      context,
                                                      snapshot,
                                                    ) {
                                                      final title =
                                                          snapshot.data ??
                                                          s.title;
                                                      return Text(
                                                        "$title - ${s.value.toStringAsFixed(1)}%",
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                              0.032,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
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
      },
    );
  }

  void _showOthersDetails(BuildContext context, List<ChartSection> sections) {
    final priceCubit = context.read<PriceCubit>();
    final allPrices = priceCubit.state.prices;
    final othersSection = sections.firstWhere((s) => s.title == "Others");
    final loc = AppLocalizations.of(context)!;

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
            title: Text(loc.translate("other_categories_details")),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${loc.translate("total_percentage")}: ${othersSection.value.toStringAsFixed(1)}%",
                  ),
                  SizedBox(height: 16),
                  if (otherCategories.isEmpty)
                    Text(loc.translate("no_other_categories"))
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
                              child: FutureBuilder<String>(
                                future: translateSmart(
                                  category,
                                  loc,
                                  loc.locale!.languageCode,
                                ),
                                builder: (context, snapshot) {
                                  final translated = snapshot.data ?? category;
                                  return Text(
                                    translated,
                                    style: TextStyle(fontSize: 16),
                                  );
                                },
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
                child: Text(loc.translate("ok")),
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
}
