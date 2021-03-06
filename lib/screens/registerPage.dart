import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_book/components/constant.dart';
import 'package:money_book/components/roundButton.dart';
import 'package:money_book/services/auth.dart';
import 'package:money_book/screens/wrapper.dart';

// ignore: camel_case_types
class registerScreen extends StatefulWidget {
  static String id = 'registerPage';
  @override
  _registerScreenState createState() => _registerScreenState();
}

// ignore: camel_case_types
class _registerScreenState extends State<registerScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fullname = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 100.0,
                        child: Image.asset('assets/images/splash.png'),
                      ),
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
                SizedBox(height: 8.0),
                Container(
                  child: Flexible(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Enter your fullname' : null,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() => fullname = value);
                            },
                            decoration: vTextFileDecoration.copyWith(
                                hintText: 'Enter Your fullname'),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Enter an email' : null,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() => email = value);
                            },
                            decoration: vTextFileDecoration.copyWith(
                                hintText: 'Enter Your Email'),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a password' : null,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() => password = value);
                            },
                            decoration: vTextFileDecoration.copyWith(
                                hintText: 'Enter Your Password 6+ chars long'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                RoundButton(
                    buttonTitle: 'Register',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.registermail(
                            email: email, password: password, fullname: fullname);
                        
                        if (result == null) {
                          setState(() => error = 'please supply a valid email and password 6+');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          Navigator.pushNamed(context, Wrapper.id);
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data Invalid')),
                      );
                    },
                    warna: Colors.blueGrey),
                SizedBox(
                  height: 12.0,
                ),
                Center(
                    child: Text(
                  error,
                  style:
                      TextStyle(fontSize: 14.0, color: Colors.redAccent.shade700),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
