import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'updateItem.dart';
// import 'package:money_book/database/item.dart';

class ListItems extends StatefulWidget {
  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  final FirebaseAuth user = FirebaseAuth.instance;
  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('items')
              .where('userId', isEqualTo: user.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              print(user.currentUser!.uid);
              return Center(
                child: Container(
                  child: Text('Data Kosong silakan masukkan data'),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  //items index
                  final item = snapshot.data!.docs[index];
                  final id = snapshot.data!.docs[index]['id'];
                  return ListTile(
                    title: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama Item : ' + item['namaItem']),
                          Text('Harga Beli item: ' +
                              item['hargaBeli'].toString()),
                          Text('Stok : ' + item['stok'].toString()),
                          // buttonItems(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonItems(
                                  warna: Color(0xff54d179),
                                  onTap: () {
                                    debugPrint('sudah');
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              child:UpdateItem(itemId: id,),
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
                                    // setState(() {
                                    FirebaseFirestore.instance
                                        .collection('items')
                                        .doc(item['id'])
                                        .delete();
                                  },
                                  ikon: Icons.delete),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
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
