import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carpool/components/rounded_button.dart';
import 'package:carpool/components/toggle.dart';
import 'package:carpool/components/rounded_input_field.dart';
import 'package:carpool/components/rounded_password_field.dart';
import 'package:carpool/services/auth.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const LoginScreen({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(60.0),
          child: Builder(builder:(BuildContext context){
            return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "truRide",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Color(0xFF6F35A5),)
              ),
//              SizedBox(height: size.height * 0.01),
              Image.asset(
              "assets/images/cars.png",
                height: 300,
                width: 250,
              ),
              //SizedBox(height: size.height * 0.3),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
                email: _emailController,
              ),
              RoundedPasswordFieldd(
                onChanged: (value) {},
                password: _passwordController,
              ),
              RoundedButton(
                key: const ValueKey("signIn"),
                text: "LOGIN",
                press: () async {
                  final String retVal = await Auth(auth: widget.auth).signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  if (retVal == "Success") {
                    _emailController.clear();
                    _passwordController.clear();
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(retVal),
                      ),
                    );
                  }
                },
              ),
              RoundedButton(
                key: const ValueKey("createAccount"),
                text: "Create Account",
                press:() async {
                  final String retVal =
                  await Auth(auth: widget.auth).createAccount(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  if (retVal == "Success") {
                    _emailController.clear();
                    _passwordController.clear();
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(retVal),
                      ),
                    );
                  }
                },
              ),
              //SizedBox(height: size.height * 0.03),
//            AlreadyHaveAnAccountCheck(
//              press: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) {
//                      return SignUpScreen();
//                    },
//                  ),
//                );
//              },
//            ),
            ],
          );
        }),
      ),
    ),
    ),);
  }
}
