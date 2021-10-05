import 'package:flutter/material.dart';

// ignore: camel_case_types
class inputFieldItem extends StatelessWidget {
  // inputFieldItem({required this.name, required)
  final String nameInput;
  final ValueChanged<String>? value;
  final TextInputType typeInput;
  inputFieldItem({required this.nameInput,required this.value, required this.typeInput});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nameInput,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
        TextField(
          autofocus: true,
          keyboardType: typeInput,
          textAlign: TextAlign.center,
          onChanged:value,
        ),
      ],
    );
  }
}
