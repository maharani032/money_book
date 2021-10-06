import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../inputField.dart';

// final _firestore = FirebaseFirestore.instance;
CollectionReference items = FirebaseFirestore.instance.collection('items');

class UpdateItem extends StatefulWidget {
  final String itemId;
  UpdateItem({required this.itemId});

  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  // TextEditingController _namaInput = TextEditingController();
  // TextEditingController _hargaInput = TextEditingController();
  // TextEditingController _stokInput = TextEditingController();
  String namaItem = '';
  String stok = '';
  String hargaBeli = '';
  // @override
  // void initState() {
  //   _namaInput.addListener(() {
  //     setState(() {
  //       namaItem = _namaInput.text;
  //     });
  //   });
  //   _hargaInput.addListener(() {
  //     setState(() {
  //       hargaBeli = _hargaInput.text;
  //     });
  //   });
  //   _stokInput.addListener(() {
  //     setState(() {
  //       stok = _stokInput.text;
  //     });
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _namaInput.dispose();
  //   _hargaInput.dispose();
  //   _stokInput.dispose();
  //   super.dispose();
  // }

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
          hargaBeli=snapshot.data!['hargaBeli'].toString();
          stok=snapshot.data!['stok'].toString();
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
              child: Container(
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
                            await FirebaseFirestore.instance
                                .collection('items')
                                .doc(id)
                                .update({
                              'namaItem': namaItem,
                              'stok': int.parse(stok),
                              'hargaBeli': int.parse(hargaBeli)
                            }).then((result) {
                              Navigator.pop(context);
                            }).catchError((onError) {
                              print(onError);
                              Navigator.pop(context);
                            });
                          },
                          child: Text('update Item'))
                    ]),
              ),
            ),
          );
        });
  }
}
