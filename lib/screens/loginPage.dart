import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_book/components/constant.dart';
import 'package:money_book/screens/wrapper.dart';
import 'package:money_book/services/auth.dart';
import '../components/roundButton.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final requiredValidator =
      RequiredValidator(errorText: 'this field is required');
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: requiredValidator,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                    decoration: vTextFileDecoration.copyWith(
                        hintText: 'Enter Your Email'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    validator: requiredValidator,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                    decoration: vTextFileDecoration.copyWith(
                        hintText: 'Enter Your Password'),
                  ),
                ],
              ),
            ),
            RoundButton(
                buttonTitle: 'Log In',
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result=await _auth.logInUser(email: email, password: password);
                    if(result==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data Invalid')),
                    );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                    );
                    Navigator.pushNamed(context, Wrapper.id);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data Invalid')),
                  );
                },
                warna: Colors.blueGrey),
          ],
        ),
      ),
    );
  }
}
