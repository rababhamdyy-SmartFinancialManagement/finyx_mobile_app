import '../../models/chart_section.dart';

class ChartState {
  final List<ChartSection> sections;
  ChartState(this.sections);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartState &&
          runtimeType == other.runtimeType &&
          sections.toString() == other.sections.toString();

  @override
  int get hashCode => sections.hashCode;

  @override
  String toString() {
    return 'ChartState{sections: ${sections.map((e) => e.toString()).toList()}}';
  }
}