import 'package:flutter/material.dart';
import 'package:money_book/logic/auth.dart';
 
class MyPage3 extends StatefulWidget {
  @override
  _MyPage3State createState() => _MyPage3State();
}

class _MyPage3State extends State<MyPage3> {
  final AuthService _auth = AuthService();
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Container(
          child:Text('tesr')
        )
      ]
    );
  }
}