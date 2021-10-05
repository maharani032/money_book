import 'package:flutter/material.dart';
import 'package:money_book/components/addItem.dart';
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
        
          padding: EdgeInsets.only(top: 60.0,left:30.0,right: 30.0,bottom:30.0),
          child: Column(
        children: [Container(height: 300, decoration: BoxDecoration())],
      )),
    );
  }
}
