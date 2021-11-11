import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/MyUser.dart';
import '../models/user.dart';
import 'firestoreauth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  // login in with email& password
  Future logInUser({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        print('No user found for that email');
        return null;
      } else if (err.code == 'wrong-password') {
        print('wrong password');
        return null;
      }
    }
  }

  //register with email & password
  Future createUser(
      {required String password,
      required String email,
      required String fullname}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreService.createUser(
          Usermodel(id: result.user!.uid, email: email, fullname: fullname));
      User user = result.user!;
      print(user);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registermail(
      {required String email,
      required String password,
      required String fullname}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreService.createUser(
          Usermodel(id: result.user!.uid, fullname: fullname, email: email));
      User user = result.user!;
      return _userFromFirebaseUser(user);
      // await createUser(email: email, password: password, fullname: fullname);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign in with google
  Future logInwGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print('test masukin akun ke result');
      UserCredential result = await _auth.signInWithCredential(credential);
      await _firestoreService.createUser(Usermodel(
          id: result.user!.uid,
          email: googleSignInAccount.email,
          fullname: googleSignInAccount.displayName.toString()));
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (err) {
      print(err.message);
      throw err;
    }
  }

  //sign out
  Future logOut() async {
    try {
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
