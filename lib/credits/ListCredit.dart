import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListCredit extends StatefulWidget {
  @override
  _ListCreditState createState() => _ListCreditState();
}

class _ListCreditState extends State<ListCredit> {
  final FirebaseAuth user = FirebaseAuth.instance;
  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('credits')
            .where('userId', isEqualTo: user.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print(user.currentUser!.uid);
            return Center(
                child: Container(
                  child: Text('Data Kosong silakan masukkan data'),
                ),
              );
          } if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            return ListView.builder( 
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                
              })
        },
      ),
    );
  }
}
