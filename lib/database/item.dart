import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_book/models/items.dart';

class ItemDatabase {
  Future<String> getUserId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final String uid = auth.currentUser!.uid;
    final result = await users.doc(uid).get();
    return result['id'];
  }

  
  CollectionReference itemDB = FirebaseFirestore.instance.collection('items');
  
  // Future CreateIdItem()
  Future addItem(
      {required String namaItem,
      required String stok,
      required String hargaItem}) async {
        FirebaseAuth user = FirebaseAuth.instance;
        String userId= user.currentUser!.uid;
    return await itemDB.add(ItemModel(
      
        namaItem: namaItem, stok: stok, hargaBeli: hargaItem, userId: userId).toMap()).then((value) => print('item be add')).catchError((err)=>print('err'));
  }
  // Future addItemStore(ItemModel item) async {
  //   try {
  //     print('coba add item di firestore');
  //     return await itemDB.doc(item.id).set(item.toJson());
  //   } catch (e) {
  //     print('error di firestore item');
  //     return e;
  //   }
  // }

  // Future addItem(
  //     {required String namaItem,
  //     required String stok,
  //     required String hargaItem}) async {

  // itemDB.add()
  //   // await addItemStore(ItemModel(
  //   //     id: ,
  //   //     namaItem: namaItem,
  //   //     stok: stok,
  //   //     hargaBeli: hargaItem,
  //   //     userId: userId));
  // }
}
