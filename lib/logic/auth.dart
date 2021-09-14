import 'package:firebase_auth/firebase_auth.dart';
import '../models/MyUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj base of firebaseUser
  MyUser? _userFromFirebaseUser(User user) {
    return MyUser(uid: user.uid);
  }

// auth change user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // login in anon
  Future logInanon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // login in with email& password

  //register with email & password
  Future registerEmailnPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
