import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Blue', percent: 40, color: const Color(0xff0293ee)),
    Data(name: 'Orange', percent: 30, color: Color.fromARGB(255, 226, 75, 16)),
    Data(name: 'Black', percent: 15, color: Color.fromARGB(255, 29, 29, 28)),
    Data(name: 'Green', percent: 15, color: Color.fromARGB(255, 41, 151, 26)),
  ];
}

class Data {
  final String name;
  final double percent;
  final Color color;
  Data({required this.name, required this.percent, required this.color});
}