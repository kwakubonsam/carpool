import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerModel {
  String name;
  String destination;
  String payment;
  String price;
  String number;
  int datetime;

 PassengerModel({
   this.name,
   this.destination,
   this.payment,
   this.datetime,
   this.number,
   this.price
  });

  PassengerModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    name = documentSnapshot.data()['name'] as String;
    destination = documentSnapshot.data()['destination'] as String;
    payment = documentSnapshot.data()['payment'] as String;
    price = documentSnapshot.data()['price'] as String;
    number = documentSnapshot.data()['number'] as String;
    datetime = documentSnapshot.data()['time'] as int;
  }


}

