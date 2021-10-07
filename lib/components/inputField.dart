import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// ignore: camel_case_types
class inputFieldItem extends StatelessWidget {
  // inputFieldItem({required this.name, required)
  final requiredValidator = RequiredValidator(errorText: 'this field is required');  
  final String nameInput;
  final ValueChanged? value;
  final TextInputType typeInput;
  final TextEditingController controller;
  inputFieldItem(
      {
         required this.controller ,required this.nameInput, required this.value, required this.typeInput});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nameInput,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
        TextFormField(
          validator:requiredValidator,
          controller: controller,
          autofocus: true,
          keyboardType: typeInput,
          textAlign: TextAlign.center,
          onChanged: value,
        ),
      ],
    );
  }
}
