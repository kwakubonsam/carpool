import 'package:carpool/screens/confirmemail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carpool/screens/home.dart';
import 'package:carpool/screens/login/login_screen.dart';
import 'package:carpool/services/auth.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.fallback(),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Root();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        },
      ),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:Auth(auth: _auth).onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid != null) {
            snapshot.data.reload();
            return snapshot.data.emailVerified ? Home(
              auth: _auth,
            ) : ConfirmEmail(auth: _auth);
          } else {
            return LoginScreen(auth: _auth);
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        }
      }, //Auth stream
    );
  }
}
