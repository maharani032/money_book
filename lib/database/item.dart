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
      required int stok,
      required int hargaBeli}) async {
    FirebaseAuth user = FirebaseAuth.instance;
    String userId = user.currentUser!.uid;
    return await itemDB
        .add(ItemModel(
                id: '',
                namaItem: namaItem,
                stok: stok,
                hargaBeli: hargaBeli,
                userId: userId)
            .toMap())
        .then((value) => {
              itemDB.doc(value.id).update({
                'id': value.id,
              })
            })
        // ignore: invalid_return_type_for_catch_error
        .catchError((err) => print('err'));
  }

  // Future getItemsByuserId(String userId) async {
  //   return itemDB.where('userId', isEqualTo: userId);
  // }
}
