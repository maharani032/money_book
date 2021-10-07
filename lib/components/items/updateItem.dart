import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../inputField.dart';

CollectionReference items = FirebaseFirestore.instance.collection('items');

class UpdateItem extends StatefulWidget {
  final String itemId;
  UpdateItem({required this.itemId});

  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final _formKey = GlobalKey<FormState>();
  String namaItem = '';
  String stok = '';
  String hargaBeli = '';

  @override
  Widget build(BuildContext context) {
    String id = widget.itemId;

    return StreamBuilder<DocumentSnapshot>(
        stream: items.doc(id).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: Text('Null Data'),
              ),
            );
          }
          //final item = snapshot.data!['namaItem'];

          namaItem = snapshot.data!['namaItem'];
          hargaBeli = snapshot.data!['hargaBeli'].toString();
          stok = snapshot.data!['stok'].toString();
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            color: Color(0xff757575),
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
                      inputFieldItem(
                        nameInput: 'nama Item',
                        value: (value) {
                          namaItem = value;
                        },
                        typeInput: TextInputType.text,
                        controller: TextEditingController(text: namaItem),
                      ),
                      inputFieldItem(
                        nameInput: 'Harga Item',
                        value: (value) {
                          hargaBeli = value;
                        },
                        typeInput: TextInputType.number,
                        controller: TextEditingController(text: hargaBeli),
                      ),
                      inputFieldItem(
                        nameInput: 'Stok Item',
                        value: (value) {
                          stok = value;
                        },
                        typeInput: TextInputType.number,
                        controller: TextEditingController(text: stok),
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                          color: Colors.blue[200],
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(id)
                                  .update({
                                'namaItem': namaItem,
                                'stok': int.parse(stok),
                                'hargaBeli': int.parse(hargaBeli)
                              }).then((result) {
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
                          child: Text('update Item'))
                    ]),
              ),
            ),
          );
        });
  }
}
