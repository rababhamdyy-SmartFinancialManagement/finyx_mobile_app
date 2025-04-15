import '../../models/chart_section.dart';

class ChartState {
  final List<ChartSection> sections;
  ChartState(this.sections);

  @override
  String toString() {
    return 'ChartState{sections: ${sections.map((e) => e.toString()).toList()}}';
  }
}