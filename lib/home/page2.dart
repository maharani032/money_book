import 'package:flutter/material.dart';
import 'package:money_book/components/items/addItem.dart';
import 'package:money_book/components/items/listItem.dart';
class MyPage2 extends StatefulWidget {
  @override
  _MyPage2State createState() => _MyPage2State();
}

class _MyPage2State extends State<MyPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                      child: AddItem(),
                    ),
                  ));
        },
        backgroundColor: Color(0xff79B4B7),
        child: Icon(Icons.add),
      ),
      body: Container(
      // height: 300, 
      decoration: BoxDecoration(),
      child: ListItems(),
      ),
    );
  }
}