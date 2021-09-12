import 'package:flutter/material.dart';
import 'package:money_book/components/roundButton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_book/logic/auth.dart';
import 'package:money_book/screens/loginPage.dart';
import 'package:money_book/screens/registerPage.dart';
import 'homePage.dart';

// ignore: camel_case_types
class welcomePage extends StatefulWidget {
  static String id = 'welcomePage';

  @override
  _welcomePageState createState() => _welcomePageState();
}

// ignore: camel_case_types
class _welcomePageState extends State<welcomePage>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/splash.png'),
                    height: 120.0,
                  ),
                ),
                // ignore: deprecated_member_use
                TyperAnimatedTextKit(
                  text: ['Money Book'],
                  speed: const Duration(seconds: 1),
                  textStyle: GoogleFonts.pacifico(
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35.0,
            ),
            RoundButton(
                buttonTitle: 'Log In',
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                warna: Colors.blueAccent.shade200),
            RoundButton(
                buttonTitle: 'Register',
                onPress: () {
                  Navigator.pushNamed(context, registerScreen.id);
                },
                warna: Colors.blueAccent.shade400),
            Center(
                  child: Text(
                  'Or',
                  style: GoogleFonts.lato(),
                  ),
                ),
                RoundButton(
                buttonTitle: 'Log In as Guest',
                onPress: () async {
                  dynamic result = await _auth.logInanon();
                  if (result == null) {
                    print('error Log In as anom');
                  } else {
                    print('sign In');
                    print(result.uid);
                    
                  }
                },
                warna: Colors.black54)
          ],
        ),
      ),
    );
  }
}
