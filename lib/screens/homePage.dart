import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:money_book/home/page1.dart';
import 'package:money_book/home/page2.dart';
import 'package:money_book/home/page3.dart';
// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 1;
 
  final List<Widget> _children = [MyPage1(), MyPage2(), MyPage3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff79B4B7),
          title: Text(
            "Money Book",
            style: GoogleFonts.pacifico(
              fontSize: 25.0,
            ),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xff79B4B7),
          index: 1,
          items: [
            Icon(Icons.account_balance_wallet, size: 30),
            Icon(Icons.add, size: 30),
            Icon(Icons.account_circle_outlined, size: 30),
          ],
          onTap: (index) {
            setState(() {
              this._page = index;
            });
          },
        ),
        body: _children[_page]);
  }
}
