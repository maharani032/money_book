import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/credits.dart';

class CreditDataBase {
  Future<String> getUserId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final String uid = auth.currentUser!.uid;
    final result = await users.doc(uid).get();
    return result['id'];
  }

  CollectionReference creditDB =
      FirebaseFirestore.instance.collection('credits');
  Future addCredit(
      {required String namaCredit,
      required DateTime dateCredit,
      required int jumlah}) async {
    FirebaseAuth user = FirebaseAuth.instance;
    String userId = user.currentUser!.uid;
    return await creditDB
        .add(CreditModel(
                id: '',
                userId: userId,
                namaCredit: namaCredit,
                jumlah: jumlah,
                date: dateCredit)
            .toMap())
        .then((value) => {
              creditDB.doc(value.id).update({'id': value.id})
            })
        // ignore: invalid_return_type_for_catch_error
        .catchError((err) => print(err));
  }

  Future  getsum() async {
    num sum = 0;
    FirebaseAuth user = FirebaseAuth.instance;
    String userId = user.currentUser!.uid;

    return await creditDB
        .where('userId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((item) {
              sum = sum + item['jumlah'];
           });
          
      
      return sum;
    });
  }
}
