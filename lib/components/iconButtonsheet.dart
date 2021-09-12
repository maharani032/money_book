import 'package:flutter/material.dart';
class IconBottomSheet extends StatelessWidget {
  IconBottomSheet({this.label, this.icon, this.onPress});
  final String? label;
  final IconData? icon;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        icon: Icon(
          icon,
          size: 50,
          color: Colors.black54,
        ),
        onPressed:onPress,
        label: Text(
          label.toString(),
          style: TextStyle(fontSize: 20.0, color: Colors.black54),
        ));
  }
}