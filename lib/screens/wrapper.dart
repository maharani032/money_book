import 'package:flutter/material.dart';
import 'package:money_book/screens/homePage.dart';
import 'package:money_book/screens/welcomePage.dart';
import 'package:provider/provider.dart';
import '../models/MyUser.dart';

class Wrapper extends StatefulWidget {
  static String id = 'Wrapper';
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    // return LoginScreen();
    if (user == null) {
      return welcomePage();
    } else {
      return HomeScreen();
    }
  }
}
