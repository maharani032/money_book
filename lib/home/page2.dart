import 'package:flutter/material.dart';
import 'package:money_book/components/topbtn.dart';
import 'package:money_book/credits/AddCredit.dart';

class MyPage2 extends StatefulWidget {
  @override
  _MyPage2State createState() => _MyPage2State();
}

class _MyPage2State extends State<MyPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Row(children: [
              WidgetTop(
                namaKeterangan: 'Pengeluaran',
                jumlah: '100,000',
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
                onpress: () {},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

