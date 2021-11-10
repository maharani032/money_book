import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/debits.dart';
class DebitDataBase{
  Future<String> getUserId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final String uid = auth.currentUser!.uid;
    final result = await users.doc(uid).get();
    return result['id'];
  }
   CollectionReference debitDB =
      FirebaseFirestore.instance.collection('debits');
  Future addDebit({
    required String namaDebit,
      required DateTime dateDebit,
      required int jumlah
  })async{
    FirebaseAuth user = FirebaseAuth.instance;
    String userId = user.currentUser!.uid;
    return await debitDB.add(DebitModel(
      id: '', 
      userId: userId, 
      namaDebit: namaDebit, 
      jumlah: jumlah, 
      date: dateDebit).toMap())
      .then((value) {
        debitDB.doc(value.id).update({'id':value.id});
      })
      // ignore: invalid_return_type_for_catch_error
      .catchError((err) => print(err));
  }
}