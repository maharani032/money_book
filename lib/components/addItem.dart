import 'package:flutter/material.dart';
import 'package:money_book/database/item.dart';
import 'inputField.dart';

class AddItem extends StatefulWidget {
  AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    String namaItem='';
    String stok='';
    String hargaBeli='';
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
                  typeInput: TextInputType.text),
              inputFieldItem(
                  nameInput: 'Harga Item',
                  value: (value) {
                    hargaBeli = value;
                  },
                  typeInput: TextInputType.number),
              inputFieldItem(
                  nameInput: 'Stok Item',
                  value: (value) {
                    stok = value;
                  },
                  typeInput: TextInputType.number),
              // ignore: deprecated_member_use
              FlatButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    print('namaItem :' + namaItem);
                    _itemDB.addItem(
                        namaItem: namaItem, stok: stok, hargaItem: hargaBeli);
                    Navigator.pop(context);
                  },
                  child: Text('add Item'))
            ],
          ),
        ),
      ),
    );
  }
}
