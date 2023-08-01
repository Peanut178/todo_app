import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/data/pie_data.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData>getSections()=> PieData.data.asMap()
.map<int, PieChartSectionData>((index, data){
  final value = PieChartSectionData(
    color: data.color,
    value: data.percent,
    title: '',
  );
  return MapEntry(index, value);
})
.values
.toList();