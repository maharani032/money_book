import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:money_book/credits/UpdateCredit.dart';

class ListCredit extends StatefulWidget {
  @override
  _ListCreditState createState() => _ListCreditState();
}

class _ListCreditState extends State<ListCredit> {
  var format = NumberFormat('###,###,###,###');
  final FirebaseAuth user = FirebaseAuth.instance;
  var formatter = new DateFormat('yyyy-MM-dd');

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
                  // ignore: unused_local_variable
                  var datecredit = credit['date'];
                  String formatDate(DateTime datecredit) {
                    final DateFormat formatter = DateFormat.yMMMMd('en_US');
                    String date = formatter.format(datecredit);
                    return date;
                  }

                  final id = snapshot.data!.docs[index]['id'];
                  return ListTile(
                    title: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            credit['namaCredit'].toUpperCase(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            format.format(credit['jumlah']).toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            formatDate(credit['date'].toDate()),
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonItems(
                                    warna: Color(0xff54d179),
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context, 
                                        builder: (context)=>SingleChildScrollView(
                                          child: Container(
                                            child: UpdateCredit(creditId:id),
                                          ),
                                        ));
                                    },
                                    ikon: Icons.drive_folder_upload_sharp),
                                SizedBox(
                                  width: 10,
                                ),
                                ButtonItems(
                                    warna: Colors.red,
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection('credits')
                                          .doc(credit['id'])
                                          .delete();
                                    },
                                    ikon: Icons.delete)
                              ])

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

class ButtonItems extends StatelessWidget {
  final Color warna;
  final IconData ikon;
  final VoidCallback onTap;
  ButtonItems({required this.warna, required this.onTap, required this.ikon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
              child: Icon(
            ikon,
            size: 20,
          ))),
    );
  }
}
