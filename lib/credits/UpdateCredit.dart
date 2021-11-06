import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book/components/inputField.dart';

CollectionReference credits = FirebaseFirestore.instance.collection('credits');

class UpdateCredit extends StatefulWidget {
  final String creditId;
  UpdateCredit({required this.creditId});
  // const UpdateCredit({Key? key}) : super(key: key);

  @override
  _UpdateCreditState createState() => _UpdateCreditState();
}

class _UpdateCreditState extends State<UpdateCredit> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  var formatNum = NumberFormat('###,###,###,###');
  final format = DateFormat("dd-mm-yyyy");
  String namaCredit = '';
  String jumlahCredit = '';
  // final _namaCredit = TextEditingController();
  // ignore: unused_field
  // final _jumlahCredit = TextEditingController();
  late DateTime dateCredit;
  

  @override
  Widget build(BuildContext context) {
    String id = widget.creditId;
    return StreamBuilder<DocumentSnapshot>(
        stream: credits.doc(id).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: Text('Null Data'),
              ),
            );
          }
          namaCredit = snapshot.data!['namaCredit'];
          // _namaCredit.text = namaCredit;
          jumlahCredit=snapshot.data!['jumlah'].toString();
          dateCredit = snapshot.data!['date'].toDate();
          return Flexible(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('* scroll to down.',style: TextStyle(fontSize: 9),),
                      inputFieldItem(
                          nameInput: 'Nama Pengeluaran',
                          value: (value) {
                            namaCredit = value;
                          },
                          controller: TextEditingController(text: namaCredit),
                          typeInput: TextInputType.text,
                          ),
                      inputFieldItem(
                          nameInput: 'jumlah Pengeluaran',
                          value: (value) {
                            jumlahCredit = value;
                          },
                          controller: TextEditingController(text: jumlahCredit),
                          typeInput: TextInputType.number, 
                        ),
                      Column(
                        children: [
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
                              initialDateTime: dateCredit,
                              onDateTimeChanged: (DateTime newDateTime) {
                                dateCredit = newDateTime;
                              },
                              dateOrder: DatePickerDateOrder.dmy,
                            ),
                          )
                        ],
                      ),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await FirebaseFirestore.instance
                                  .collection('credits')
                                  .doc(id)
                                  .update({
                                'namaCredit': namaCredit,
                                'jumlah': int.parse(jumlahCredit),
                                'date': dateCredit
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
                          child: Text('Tambah Pengeluaran'))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
