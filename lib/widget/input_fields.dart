import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  const InputField({
    super.key,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Row(children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 22),
              focusedBorder: InputBorder.none,
              border: InputBorder.none),
        ))
      ]),
    );
  }
}