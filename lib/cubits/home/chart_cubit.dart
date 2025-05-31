import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/chart_section.dart';
import 'chart_state.dart';
import 'package:flutter/material.dart';
import '../wallet/price_cubit.dart';

class ChartCubit extends Cubit<ChartState> {
  final UserType userType;
  final PriceCubit priceCubit;

  ChartCubit({required this.userType, required this.priceCubit})
    : super(ChartState([])) {
    priceCubit.stream.listen((priceState) {
      _updateSectionsBasedOnPrices(priceState.prices);
    });
  }

  void _updateSectionsBasedOnPrices(Map<String, double> prices) {
    if (prices.isEmpty) {
      final suggestedCategories =
          userType == UserType.individual
              ? ['Food', 'Transport', 'Housing', 'Utilities', 'Entertainment']
              : [
                'Revenue',
                'Salaries',
                'Marketing',
                'Operations',
                'Investments',
              ];

      emit(
        ChartState(
          suggestedCategories
              .map((category) => ChartSection(category, 0, Colors.grey[400]!))
              .toList(),
        ),
      );
      return;
    }

    final total = prices.values.fold(0.0, (sum, value) => sum + value);
    if (total == 0) {
      emit(ChartState([]));
      return;
    }

    final totalExpenses = prices.values.fold(0.0, (sum, value) => sum + value);

    if (totalExpenses == 0) {
      emit(ChartState([]));
      return;
    }

    var sortedEntries =
        prices.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    var topEntries = sortedEntries.take(5).toList();

    double othersValue = 0;
    if (sortedEntries.length > 5) {
      othersValue = sortedEntries
          .sublist(5)
          .fold(0.0, (sum, entry) => sum + entry.value);
    }

    List<ChartSection> sections = [];

    for (var entry in topEntries) {
      sections.add(
        ChartSection(
          entry.key,
          (entry.value / total) * 100,
          _getColorForSection(entry.key, sections.length),
        ),
      );
    }

    if (othersValue > 0) {
      sections.add(
        ChartSection("Others", (othersValue / total) * 100, Colors.grey),
      );
    }

    emit(ChartState(sections));
  }

  Color _getColorForSection(String title, int index) {
    final colors = [
      Colors.purple,
      Colors.indigo,
      Colors.pink,
      Colors.teal,
      Colors.deepOrange,
      Colors.grey,
    ];

    return colors[index % colors.length];
  }

  void updateSection(String title, double newValue) {
    final updated =
        state.sections.map((section) {
          if (section.title == title) {
            return ChartSection(title, newValue, section.color);
          }
          return section;
        }).toList();
    emit(ChartState(updated));
  }
}
