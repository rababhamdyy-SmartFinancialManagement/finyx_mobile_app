import 'package:finyx_mobile_app/models/applocalization.dart';
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
                ChartSection("Food", 30, Colors.red),
                ChartSection("Internet", 25, Colors.orange),
                ChartSection("WaterBill", 15, Colors.blue),
                ChartSection("Electricity", 10, Colors.purple),
                ChartSection("Gas", 8, Colors.pink),
                ChartSection("Others", 12, Colors.green),
              ]
            : [
                ChartSection("T Revenue", 30, Colors.red),
                ChartSection("E salaries", 10, Colors.teal),
                ChartSection("T Expenses", 20, Colors.orange),
                ChartSection("Profits", 10, Colors.blue),
                ChartSection("Losses", 15, Colors.green),
                ChartSection("Transfer", 15, Colors.purple),
                
              ])) {
    // print("ChartCubit created with userType: $userType");
    // print("Initial state: ${state.sections}");
  }

  void updateSection(String title, double newValue) {
    // print("updateSection called: title=$title, newValue=$newValue");
    final updated = state.sections.map((section) {
      if (section.title == title) {
        return ChartSection(title, newValue, section.color);
      }
      return section;
    }).toList();
    emit(ChartState(updated));
    // print("New state emitted: ${state.sections}");
  }
}