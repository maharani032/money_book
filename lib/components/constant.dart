import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
const vTextFileDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const vline = DottedLine(
  direction: Axis.horizontal,
  lineLength: 50.0,
  lineThickness: 1.0,
  dashColor: Colors.black45,
);
// ignore: camel_case_types

