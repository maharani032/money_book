import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:money_book/components/inputField.dart';
import 'package:money_book/services/creditDB.dart';
import 'package:intl/intl.dart';

class AddCredit extends StatefulWidget {
  @override
  _AddCreditState createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {
  // ignore: unused_field
  final format = DateFormat("dd-mm-yyyy");
  final _formKey = GlobalKey<FormState>();
  final _namaCredit = TextEditingController();
  final _jumlahCredit = TextEditingController();
  String namaCredit = '';
  String jumlahCredit = '';
  late DateTime dateCredit = DateTime.now();
  @override
  void initState() {
    _namaCredit.addListener(() {
      setState(() {
        namaCredit = _namaCredit.text;
      });
    });
    _jumlahCredit.addListener(() {
      setState(() {
        jumlahCredit = _jumlahCredit.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _namaCredit.dispose();
    _jumlahCredit.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    final CreditDataBase _creditDB = CreditDataBase();

    return Flexible(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    controller: _namaCredit,
                    nameInput: 'Nama Pengeluaran',
                    value: (value) {
                      namaCredit = value;
                    },
                    typeInput: TextInputType.text),
                inputFieldItem(
                    controller: _jumlahCredit,
                    nameInput: 'jumlah Pengeluaran',
                    value: (value) {
                      jumlahCredit = value;
                    },
                    typeInput: TextInputType.number),
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
                        use24hFormat: false,
                        dateOrder: DatePickerDateOrder.dmy,
                      ),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _creditDB
                            .addCredit(
                                namaCredit: namaCredit,
                                dateCredit: dateCredit,
                                jumlah: int.parse(jumlahCredit))
                            .then((result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Processing Add Data')),
                          );
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
  }
}
