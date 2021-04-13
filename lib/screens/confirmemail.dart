import 'package:flutter/material.dart';
import 'package:carpool/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfirmEmail extends StatefulWidget {
  final FirebaseAuth auth;

  const ConfirmEmail({
    Key key,
    @required this.auth,
  }) : super(key: key);
  @override
  _ConfrimEmailState createState() => _ConfrimEmailState();
}

class _ConfrimEmailState extends State<ConfirmEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Confirmation"),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 250),
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    'An email will be sent to you, click the link provided to complete registration.'
                    ' (Remember to check spam box)',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
            ),
            Center(
              child: MaterialButton(
                color: Color(0xFF6F35A5),
                child: Text(
                  "Confirm Email",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  User user = widget.auth.currentUser;
                  await user.reload();
                  user.sendEmailVerification();
                  widget.auth.signOut();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
