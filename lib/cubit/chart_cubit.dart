import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/chart_section.dart';
import '../models/user_type.dart';
import 'chart_state.dart';
import 'package:flutter/material.dart';

class ChartCubit extends Cubit<ChartState> {
  final UserType userType;

  ChartCubit({required this.userType}) : super(ChartState(
    userType == UserType.individual
      ? [
          ChartSection("Food", 40, Colors.red),
          ChartSection("Internet", 25, Colors.orange),
          ChartSection("WaterBill", 20, Colors.blue),
          ChartSection("Others", 15, Colors.green),
        ]
      : [
          ChartSection("Internet", 25, Colors.pink),
          ChartSection("Shopping", 20, Colors.redAccent),
          ChartSection("Dining & Food", 15, Colors.orange),
          ChartSection("Balance", 30, Colors.purple),
          ChartSection("Others", 10, Colors.green),
        ]
  ));

  void updateSection(String title, double newValue) {
    final updated = state.sections.map((section) {
      if (section.title == title) {
        return ChartSection(title, newValue, section.color);
      }
      return section;
    }).toList();
    emit(ChartState(updated));
  }
}
