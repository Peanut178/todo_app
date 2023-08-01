import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/input_fields.dart';

class Form extends StatelessWidget {
  const Form({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [InputField(hint: "Add title")]),
      ),
    ));
  }
}