import 'package:flutter/material.dart';

class ChartSection {
  final String title;
  final double value;
  final Color color;

  ChartSection(this.title, this.value, this.color);

  @override
  String toString() {
    return 'ChartSection{title: $title, value: $value}';
  }
}