import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carpool/models/passengermodel.dart';
import 'package:carpool/constants.dart';
import 'package:intl/intl.dart';

class RideCard extends StatefulWidget {
  final PassengerModel ride;
  final CollectionReference rides;

  const RideCard({
    Key key,
    this.ride,
    this.rides,
  }) : super(key: key);

  @override
  _RideCardState createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {

  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(widget.ride.datetime);
    return Card(
      shadowColor: Color(0xFF6F35A5),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            Text(
              "Destination: " + widget.ride.destination,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Name: " + widget.ride.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Phone number: +" + widget.ride.number,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Payment: " + widget.ride.payment,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Price: \$" + widget.ride.price,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
         Text(
              "Date: " + new DateFormat.yMMMd().format(date),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Time: " +  new DateFormat.jm().format(DateTime.parse(date.toString())),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ])),
    );
  }
}
