import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String> resetPassword(email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
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
