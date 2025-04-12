import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/chart_section.dart';
import 'chart_state.dart';
import 'package:flutter/material.dart';

class ChartCubit extends Cubit<ChartState> {
  final UserType userType;

  ChartCubit({required this.userType})
      : super(ChartState(userType == UserType.individual
            ? [
                ChartSection("Food", 40, Colors.red),
                ChartSection("Internet", 25, Colors.orange),
                ChartSection("WaterBill", 20, Colors.blue),
                ChartSection("Others", 15, Colors.green),
              ]
            : [
                ChartSection("T Revenue", 50, Colors.red),
                ChartSection("T Expenses", 20, Colors.orange),
                ChartSection("Profits", 20, Colors.blue),
                ChartSection("Losses", 10, Colors.green),
              ])) {
    print("ChartCubit created with userType: $userType");
    print("Initial state: ${state.sections}");
  }

  void updateSection(String title, double newValue) {
    print("updateSection called: title=$title, newValue=$newValue");
    final updated = state.sections.map((section) {
      if (section.title == title) {
        return ChartSection(title, newValue, section.color);
      }
      return section;
    }).toList();
    emit(ChartState(updated));
    print("New state emitted: ${state.sections}");
  }
}