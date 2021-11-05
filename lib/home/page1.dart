import 'package:flutter/material.dart';
import 'package:money_book/credits/ListCredit.dart';

class MyPage1 extends StatefulWidget {
  @override
  _MyPage1State createState() => _MyPage1State();
}

class _MyPage1State extends State<MyPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(),
        child: ListCredit(),
      ),
      );
  }
}
