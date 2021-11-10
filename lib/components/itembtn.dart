import 'package:flutter/material.dart';

class ButtonItems extends StatelessWidget {
  final Color warna;
  final IconData ikon;
  final VoidCallback onTap;
  ButtonItems({required this.warna, required this.onTap, required this.ikon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
              child: Icon(
            ikon,
            size: 20,
          ))),
    );
  }
}
