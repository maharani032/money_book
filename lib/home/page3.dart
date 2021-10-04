import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_book/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPage3 extends StatefulWidget {
  MyPage3({Key? key}) : super(key: key);

  @override
  _MyPage3State createState() => _MyPage3State();
}

class _MyPage3State extends State<MyPage3> {
  String _username ='';
  final AuthService _auth = AuthService();
  _MyPage3State(){
    getUserName().then((value) => setState((){
      _username=value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(child: Text(_username)),
      GestureDetector(
        onTap: () async {
          // print(auth.currentUser);
          await _auth.logOut();
        },
        child: Container(
            color: Colors.blue,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 20),
              ),
            )),
      )
    ]);
  }
}

Future<String> getUserName() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final String uid = auth.currentUser!.uid;
  final result = await users.doc(uid).get();
  return result['fullname'];
}
