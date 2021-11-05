import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class ListCredit extends StatefulWidget {
  @override
  _ListCreditState createState() => _ListCreditState();
}

class _ListCreditState extends State<ListCredit> {
  var format=NumberFormat('###,000');
  final FirebaseAuth user = FirebaseAuth.instance;
  final CollectionReference credits =
      FirebaseFirestore.instance.collection('credits');
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
            print(snapshot);
            return Center(
              child: Container(
                child: Text('Data Kosong silakan masukkan data'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final credit = snapshot.data!.docs[index];
                  // final id = snapshot.data!.docs[index]['id'];
                  return ListTile(
                    title: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengeluaran',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20
                            ),
                          ),
                          Text(credit['namaCredit'],
                          style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(format.format(credit['jumlah']).toString(),
                          style: TextStyle(
                              fontSize: 16
                            ),),
                          // Text(credit['date'].toString())
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
