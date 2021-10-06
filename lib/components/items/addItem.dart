import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_book/database/item.dart';
import '../inputField.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _namaInput = TextEditingController();
  final _hargaInput = TextEditingController();
  final _stokInput = TextEditingController();
  String namaItem = '';
  String stok = '';
  String hargaBeli = '';
  @override
  void initState() {
    _namaInput.addListener(() {
      setState(() {
        namaItem = _namaInput.text;
      });
    });
    _hargaInput.addListener(() {
      setState(() {
        hargaBeli = _hargaInput.text;
      });
    });
    _stokInput.addListener(() {
      setState(() {
        stok = _stokInput.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _namaInput.dispose();
    _hargaInput.dispose();
    _stokInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ItemDatabase _itemDB = ItemDatabase();
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                controller: _namaInput,
              ),
              inputFieldItem(
                nameInput: 'Harga Item',
                value: (value) {
                  hargaBeli = value;
                },
                typeInput: TextInputType.number,
                controller: _hargaInput,
              ),
              inputFieldItem(
                nameInput: 'Stok Item',
                value: (value) {
                  stok = value;
                },
                typeInput: TextInputType.number,
                controller: _stokInput,
              ),
              
              // ignore: deprecated_member_use
              FlatButton(
                  color: Colors.blue[200],
                  onPressed: () async {
                    await _itemDB
                        .addItem(
                            namaItem: namaItem,
                            stok: int.parse(stok),
                            hargaBeli: int.parse(hargaBeli)
                            )
                        .then((result) {
                      Navigator.pop(context);
                    }).catchError((onError) {
                      print(onError);
                      Navigator.pop(context);
                    });
                  },
                  child: Text('add Item'))
                  
            ],
          ),
        ),
      ),
    );
  }
}
