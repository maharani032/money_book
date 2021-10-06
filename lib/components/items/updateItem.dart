import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpdateItem extends StatefulWidget {
  String itemId;
  UpdateItem({required this.itemId});
  @override
  _UpdateItemState createState() => _UpdateItemState();
}

@override
class _UpdateItemState extends State<UpdateItem> {
  Widget build(BuildContext context) {
    return Text(widget.itemId);
  }
}
