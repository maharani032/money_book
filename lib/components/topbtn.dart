import 'package:flutter/material.dart';
// ignore: must_be_immutable
class WidgetTop extends StatelessWidget {
  String namaKeterangan;
  String jumlah;
  Color warna;
  VoidCallback onpress;
  WidgetTop({required this.onpress,required this.namaKeterangan, required this.warna,required this.jumlah});
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
          margin:EdgeInsets.all(10),
        child: TextButton(
          onPressed: onpress,
          
            style: TextButton.styleFrom(
            backgroundColor: warna,
            maximumSize: Size(70,70),
            
          ),
          child: Column(
            children: [
              Text(
                namaKeterangan,
                style: TextStyle(fontSize: 20,color: Colors.black87),
              ),
              Text(
                jumlah,
                style: TextStyle(fontSize: 20,color: Colors.black26),
              )
            ],
          ),
          
          
        ),
      ),
    );
  }
}