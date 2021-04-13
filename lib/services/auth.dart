import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Auth {
  final FirebaseAuth auth;

  Auth({this.auth});

  Stream<User> get onAuthStateChanged => auth.authStateChanges();

  Future<String> createAccount({String email, String password}) async {
    try{
        User users  = (await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )).user;

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
     User users = (await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )).user;
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
}
