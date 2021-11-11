import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:money_book/components/inputField.dart';
import 'package:money_book/components/inputwithinitial.dart';

CollectionReference debits = FirebaseFirestore.instance.collection('debits');

class UpdateDebit extends StatefulWidget {
  final String debitId;
  UpdateDebit({required this.debitId});
  @override
  _UpdateDebitState createState() => _UpdateDebitState();
}

class _UpdateDebitState extends State<UpdateDebit> {
  final _formKey = GlobalKey<FormState>();
  var formatNum = NumberFormat('###,###,###,###');
  final format = DateFormat("dd-mm-yyyy");
  String namaDebit = '';
  String jumlahDebit = '';
  late DateTime dateDebit;

  @override
  Widget build(BuildContext context) {
    String id = widget.debitId;
    return StreamBuilder<DocumentSnapshot>(
        stream: debits.doc(id).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: Text('Null Data'),
              ),
            );
          }
          namaDebit = snapshot.data!['namaDebit'];
          jumlahDebit = snapshot.data!['jumlah'].toString();
          dateDebit = snapshot.data!['date'].toDate();
          return Container(
            padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                  Text('* scroll to down.',style: TextStyle(fontSize: 9),),

                    Container(
                      child: InputwithInitial(
                        nameInput: 'Nama Pemasukan',
                        initial: namaDebit,
                        typeInput: TextInputType.text,
                        value: (value) {
                            namaDebit = value;
                            print(namaDebit);
                        },
                      ),
                    ),
                    Container(
                      child: InputwithInitial(
                        nameInput: 'Jumlah Pemasukan',
                        initial: jumlahDebit,
                        typeInput: TextInputType.number,
                        value: (value) {
                          jumlahDebit = value;
                        },
                      ),
                    ),
                    Container(
                      child: Column(children: [
                        Text(
                          'Tanggal Transaksi (${format.pattern})',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          child: CupertinoDatePicker(
                            backgroundColor: Colors.black45,
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: dateDebit,
                            onDateTimeChanged: (DateTime newDateTime) {
                              dateDebit = newDateTime;
                            },
                            dateOrder: DatePickerDateOrder.dmy,
                          ),
                        )
                      ]),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await FirebaseFirestore.instance
                                .collection('debits')
                                .doc(id)
                                .update({
                              'namaDebit': namaDebit,
                              'jumlah': int.parse(jumlahDebit),
                              'date': dateDebit
                            }).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')));
                              Navigator.pop(context);
                            }).catchError((onError) {
                              print(onError);
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Text('Tambah Pemasukan'))
                  ])),
            ),
          ],
            ),
          );
        });
  }
}
