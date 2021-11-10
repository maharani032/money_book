import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book/components/itembtn.dart';

class ListDebit extends StatefulWidget {
  @override
  _ListDebitState createState() => _ListDebitState();
}

class _ListDebitState extends State<ListDebit> {
  var format = NumberFormat('###,###,###,###');
  final FirebaseAuth user = FirebaseAuth.instance;
  var formatter = new DateFormat('yyyy-MM-dd');

  final CollectionReference debits =
      FirebaseFirestore.instance.collection('debits');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream:  debits
            .where('userId', isEqualTo: user.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
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
                  final debit = snapshot.data!.docs[index];
                  String formatDate(DateTime datedebit) {
                    final DateFormat formatter = DateFormat.yMMMMd('en_US');
                    String date = formatter.format(datedebit);
                    return date;
                  }

                  // ignore: unused_local_variable
                  final id = snapshot.data!.docs[index]['id'];
                  return ListTile(
                    title: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(debit['namaDebit'].toUpperCase(),
                              style: TextStyle(fontSize: 20)),
                          Text(format.format(debit['jumlah']).toString(),
                              style: TextStyle(fontSize: 20)),
                          Text(
                            formatDate(debit['date'].toDate()),
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonItems(
                                  warna: Color(0xff54d179),
                                  onTap: () {},
                                  ikon: Icons.drive_folder_upload_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              ButtonItems(
                                  warna: Colors.red,
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('debits')
                                        .doc(debit['id'])
                                        .delete();
                                  },
                                  ikon: Icons.delete)
                            ],
                          )
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
