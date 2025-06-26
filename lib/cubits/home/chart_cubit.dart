import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/chart_section.dart';
import 'chart_state.dart';
import 'package:flutter/material.dart';
import '../wallet/price_cubit.dart';

class ChartCubit extends Cubit<ChartState> {
  final UserType userType;
  final PriceCubit priceCubit;
  bool _initialLoad = true;

  ChartCubit({required this.userType, required this.priceCubit})
      : super(ChartState(_getInitialSections(userType))) {
    _updateSectionsBasedOnPrices(priceCubit.state.prices);
    priceCubit.stream.listen((priceState) {
      _updateSectionsBasedOnPrices(priceState.prices);
    });
  }

  static List<ChartSection> _getInitialSections(UserType userType) {
    final suggestedCategories = userType == UserType.individual
        ? ['Food', 'Transport', 'Housing', 'Utilities', 'Entertainment']
        : ['Revenue', 'Salaries', 'Marketing', 'Operations', 'Investments'];

    return suggestedCategories
        .map((category) => ChartSection(category, 0, Colors.grey[400]!))
        .toList();
  }

  void _updateSectionsBasedOnPrices(Map<String, double> prices) {
    if (_initialLoad) {
      _initialLoad = false;
      emit(ChartState(_getInitialSections(userType)));
    }

    if (prices.isEmpty) {
      emit(ChartState(_getInitialSections(userType)));
      return;
    }

    final total = prices.values.fold(0.0, (sum, value) => sum + value);
    if (total == 0) {
      emit(ChartState(_getInitialSections(userType)));
      return;
    }

    var sortedEntries = prices.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    var topEntries = sortedEntries.take(5).toList();

    double othersValue = sortedEntries.length > 5
        ? sortedEntries.sublist(5).fold(0.0, (sum, entry) => sum + entry.value)
        : 0;

    List<ChartSection> sections = topEntries.map((entry) {
      return ChartSection(
        entry.key,
        (entry.value / total) * 100,
        _getColorForSection(entry.key, topEntries.indexOf(entry)),
      );
    }).toList();

    if (othersValue > 0) {
      sections.add(ChartSection("Others", (othersValue / total) * 100, Colors.grey));
    }

    if (sections.isEmpty) sections = _getInitialSections(userType);
    emit(ChartState(sections));
  }

  Color _getColorForSection(String title, int index) {
    final colors = [Colors.purple, Colors.indigo, Colors.pink, Colors.teal, Colors.deepOrange, Colors.grey];
    return colors[index % colors.length];
  }

  void updateSection(String title, double newValue) {
    final updated = state.sections.map((section) {
      return section.title == title
          ? ChartSection(title, newValue, section.color)
          : section;
    }).toList();
    emit(ChartState(updated));
  }

  void reset(UserType newUserType) {
  _initialLoad = true;
  emit(ChartState(_getInitialSections(newUserType)));
}

}