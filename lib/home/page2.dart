import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book/components/topbtn.dart';
import 'package:money_book/credits/AddCredit.dart';
import 'package:money_book/debits/AddDebit.dart';
import 'package:money_book/services/creditDB.dart';

class MyPage2 extends StatefulWidget {
  @override
  _MyPage2State createState() => _MyPage2State();
}

class _MyPage2State extends State<MyPage2> {
  var format = NumberFormat('###,###,###,###');
  String _credit = '';
  _MyPage2State() {
    CreditDataBase().getsum().then((value) => setState(() {
          _credit = format.format(value).toString();
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin:EdgeInsets.all(10),
            width:double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xff79B4B7)
            ),
            child: Column(
              children: [
              Text('Total Transaksi',
              style: TextStyle(fontSize: 20,color: Colors.black87),
              ),
              Text('98.000',
              style: TextStyle(fontSize: 20,color: Colors.black26),
              )
              ],
            )),
          Flexible(
            child: Row(children: [
              WidgetTop(
                namaKeterangan: 'Pengeluaran',
                //format.format(_credit.toString())
                jumlah: _credit,
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
                        )
                          );
                },
              ),
              WidgetTop(
                namaKeterangan: 'Pemasukan',
                jumlah: '100,000',
                warna: Color(0xffCEE5D0),
                onpress: () {
                  showModalBottomSheet(context: context,
                  isScrollControlled: true,
                   builder: (context)=>SingleChildScrollView(
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

