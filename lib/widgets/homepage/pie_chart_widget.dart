import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/cubits/home/chart_state.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PieChartWidget extends StatelessWidget {
  final double chartSize;
  final UserType userType;

  const PieChartWidget({Key? key, required this.chartSize, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        return SizedBox(
          height: chartSize,
          width: chartSize,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: chartSize * 0.25,
              sectionsSpace: 2,
              sections: state.sections.map((section) {
                return PieChartSectionData(
                  value: section.value,
                  title: userType == UserType.individual ? "" : "${section.title} - ${section.value.toInt()}%",
                  color: section.color,
                  radius: chartSize * 0.25,
                  titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}