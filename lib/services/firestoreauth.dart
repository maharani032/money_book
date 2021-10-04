import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_book/models/user.dart';

class FirestoreService {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  Future createUser(Usermodel user) async {
    try {
      print('coba create user in firestore');
      return await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      print('error di firestore Service');
      return e;
    }
  }
}
