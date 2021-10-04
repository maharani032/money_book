import 'package:flutter/material.dart';
import 'package:money_book/services/auth.dart';
import 'package:money_book/models/MyUser.dart';
import 'package:money_book/screens/homePage.dart';
import 'package:money_book/screens/loginPage.dart';
import 'package:money_book/screens/registerPage.dart';
import 'package:money_book/screens/welcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:money_book/screens/wrapper.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      catchError: (_,__) => null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Wrapper.id,
        routes: {
          Wrapper.id:(context)=>Wrapper(),
          welcomePage.id:(context)=>welcomePage(),
          Wrapper.id:(context)=>Wrapper(),
          registerScreen.id:(context)=>registerScreen(),
          LoginScreen.id:(context)=>LoginScreen(),
          HomeScreen.id:(context)=>HomeScreen()
        },
      ),
    );
  }
}

