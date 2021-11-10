import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book/credits/ListCredit.dart';
import 'package:money_book/services/creditDB.dart';

// import 'package:money_book/credits/ListCredit.dart' as lc;
class MyPage1 extends StatefulWidget {
  @override
  _MyPage1State createState() => _MyPage1State();
}

class _MyPage1State extends State<MyPage1> {
  var format = NumberFormat('###,###,###,###');
  String _sum = '';
  _MyPage1State() {
    CreditDataBase().getsum().then((value) => setState(() {
          _sum = format.format(value).toString();
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            // _sum,
            'Total Pengeluaran : ' + _sum,
            style: TextStyle(fontSize: 16.0),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(),
              child: ListCredit(),
            ),
          ),
        ],
      ),
    );
  }
}


