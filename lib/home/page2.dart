import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book/components/topbtn.dart';
import 'package:money_book/credits/AddCredit.dart';
import 'package:money_book/debits/AddDebit.dart';
import 'package:money_book/services/creditDB.dart';
import 'package:money_book/services/debitDB.dart';

class MyPage2 extends StatefulWidget {
  @override
  _MyPage2State createState() => _MyPage2State();
}

class _MyPage2State extends State<MyPage2> {
  var format = NumberFormat('###,###,###,###');
  num credit = 0;
  num debit = 0;
  num total = 0;
  String jmlh = '';

  _MyPage2State() {
    CreditDataBase().getsum().then((value) => setState(() {
          credit = value;
          total = debit;
          total -= credit;
        }));
    DebitDataBase().getsum().then((value) => setState(() {
          debit = value;
          total = debit;
          total -= credit;
        }));
  }
  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(color: Color(0xff79B4B7)),
              child: Column(
                children: [
                  Text(
                    'Total Transaksi',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  Text(
                    format.format(total).toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                  )
                ],
              )),
          Flexible(
            child: Row(children: [
              WidgetTop(
                namaKeterangan: 'Pengeluaran',
                //format.format(_credit.toString())
                jumlah: format.format(credit).toString(),
                warna: Color(0xffE84A5F),
                onpress: () {
                  // Navigator.pushNamed(context, PengeluaranPage.id);
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                            child: Container(
                              child: AddCredit(),
                            ),
                          ));
                },
              ),
              WidgetTop(
                namaKeterangan: 'Pemasukan',
                jumlah: format.format(debit).toString(),
                warna: Color(0xffCEE5D0),
                onpress: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                            child: Container(
                              child: AddDebit(),
                            ),
                          ));
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

