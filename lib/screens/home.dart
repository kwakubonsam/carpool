import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carpool/components/rounded_button.dart';
import 'package:carpool/screens/driver/drivers.dart';
import 'package:carpool/screens/passenger/passenger.dart';
import 'package:carpool/services/auth.dart';
import 'package:carpool/constants.dart';


class Home extends StatefulWidget {
  final FirebaseAuth auth;

  const Home({Key key, this.auth}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Mode"),
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
                key: const ValueKey("signOut"),
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  Auth(auth: widget.auth).signOut();
                })
          ],
        ),
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              Center(
                  child: Column(children: <Widget>[
                SizedBox(height: size.height * 0.30),
                RoundedButton(
                  text: 'Passenger',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Passenger();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "Driver",
                  color: kPrimaryLightColor,
                  textColor: Colors.black,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Driver();
                        },
                      ),
                    );
                  },
                ),
              ])),
            ],
          ),
        ));
  }
}
