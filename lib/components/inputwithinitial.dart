import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class InputwithInitial extends StatelessWidget {
  final requiredValidator =
      RequiredValidator(errorText: 'this field is required');
  final String nameInput;
  final ValueChanged? value;
  final initial;
  final TextInputType typeInput;
  InputwithInitial({required this.nameInput,required this.typeInput, required this.value, required this.initial});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Nama Pemasukan',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
        TextFormField(
          initialValue: initial,
          validator: requiredValidator,
          autofocus: true,
          textAlign: TextAlign.center,
          onChanged: value,
          keyboardType: typeInput,
          // textInputAction: TextInputAction.join,
        ),
      ],
    );
  }
}
