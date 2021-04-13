import 'package:flutter/material.dart';
import 'package:carpool/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carpool/services/auth.dart';

class PasswordReset extends StatefulWidget {
  final FirebaseAuth auth;
  const PasswordReset({
    Key key,
    @required this.auth,
}) : super(key: key);
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  RegExp email = RegExp(r'[a-z]{2,3}\d{4}@truman+\.edu');
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Builder(
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: const ValueKey("username"),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(hintText: "Email"),
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        key: const ValueKey("Reset"),
                        color: kPrimaryColor,
                        onPressed: () async {
                          if (!email.hasMatch(_emailController.text)) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Invalid Email"),
                              ),
                            );
                          } else {
                            final String retVal = await Auth(auth: widget.auth).resetPassword(_emailController.text);
                            if (retVal == "Success") {
                              _emailController.clear();
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("A reset email has been sent to you"),
                                ),
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(retVal),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ))),
    );
  }
}
