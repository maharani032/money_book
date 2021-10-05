import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_book/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPage3 extends StatefulWidget {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      Container(
        height: 100,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
    
            children: [
              Icon(Icons.person,size:50),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    _username,
                    style: TextStyle(fontSize: 20),
                    ),
                ),
              ),
            ],
          ),
        )
          ),
          SizedBox(
            height: 10,
          ),
      GestureDetector(
        onTap: () async {
          await _auth.logOut();
        },
        child: Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.logout,size: 50,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Log Out',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
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
