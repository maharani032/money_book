import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book/components/inputField.dart';
import 'package:money_book/services/debitDB.dart';

class AddDebit extends StatefulWidget {
  const AddDebit({Key? key}) : super(key: key);

  @override
  _AddDebitState createState() => _AddDebitState();
}

class _AddDebitState extends State<AddDebit> {
  var formatNum = NumberFormat('###,###,###,###');
  final format = DateFormat("dd-mm-yyyy");
  final _formKey = GlobalKey<FormState>();
  final _namaDebit = TextEditingController();
  final _jumlahDebit = TextEditingController();
  String namaDebit = '';
  String jumlahDebit = '';
  late DateTime dateDebit = DateTime.now();

  @override
  void initState() {
    _namaDebit.addListener(() {
      setState(() {
        namaDebit = _namaDebit.text;
      });
    });
    _jumlahDebit.addListener(() {
      setState(() {
        // _jumlahCredit.text = formatNum.format(jumlahCredit).replaceAll('', "");
        jumlahDebit = _jumlahDebit.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _namaDebit.dispose();
    _jumlahDebit.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DebitDataBase _debitDB = DebitDataBase();
    return Container(
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
              Text('* scroll to down.',style: TextStyle(fontSize: 9),),

              inputFieldItem(
                  controller: _namaDebit,
                  nameInput: 'Nama Pemasukan',
                  value: (value) {
                    namaDebit = value;
                  },
                  typeInput: TextInputType.text),
              inputFieldItem(
                  controller: _jumlahDebit,
                  nameInput: 'Jumlah Pemasukan',
                  value: (value) {
                    jumlahDebit = value;
                  },
                  typeInput: TextInputType.number),
              Container(
                child: Column(
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
                        initialDateTime: dateDebit,
                        onDateTimeChanged: (DateTime newDateTime) {
                          dateDebit = newDateTime;
                        },
                        dateOrder: DatePickerDateOrder.dmy,
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: () async {
                    // print(dateCredit);
                    if (_formKey.currentState!.validate()) {
                      await _debitDB
                          .addDebit(
                              namaDebit: namaDebit,
                              dateDebit: dateDebit,
                              jumlah: int.parse(jumlahDebit))
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
    );
  }
}
