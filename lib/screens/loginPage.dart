import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_book/components/constant.dart';
// import 'package:money_book/logic/auth.dart';
import '../components/roundButton.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/splash.png'),
                ),
              ),
            ),
            Center(
              child: Text(
                'Money Book',
                style: GoogleFonts.pacifico(fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() => email = value);
              },
              decoration:
                  vTextFileDecoration.copyWith(hintText: 'Enter Your Email'),
            ),
            SizedBox(height: 8.0),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() => password = value);
              },
              decoration:
                  vTextFileDecoration.copyWith(hintText: 'Enter Your Password'),
            ),
            RoundButton(
                buttonTitle: 'Log In',
                onPress: () async {},
                warna: Colors.blueGrey),
            Center(
              child: Text(
                'Or',
                style: GoogleFonts.lato(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
