import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book/debits/ListDebit.dart';
import 'package:money_book/services/debitDB.dart';

class MyPage4 extends StatefulWidget {
  @override
  _MyPage4State createState() => _MyPage4State();
}

class _MyPage4State extends State<MyPage4> {
  var format = NumberFormat('###,###,###,###');
  String _sum = '';
  _MyPage4State() {
    DebitDataBase().getsum().then((value) => setState(() {
          _sum = format.format(value).toString();
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          Text('total pemasukan : '+_sum),
          Flexible(child: Container(child: ListDebit(),))
        ],),
      ),
    );
  }
}
