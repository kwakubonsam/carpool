import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carpool/services/database.dart';
import 'package:carpool/models/passengermodel.dart';
import 'package:intl/intl.dart';

class RideSearch extends SearchDelegate<PassengerModel> {
  final Stream<List<PassengerModel>> ride;

  RideSearch(this.ride);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, size: 36.5),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: Database(rides: FirebaseFirestore.instance.collection('ridz')).streamRides(),
      builder: (context, AsyncSnapshot<List<PassengerModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No data'),
          );
        }

        final results = snapshot.data
            .where((a) => a.destination.toLowerCase().contains(query.toLowerCase()));

        if (results.isEmpty) {
          return Center(
            child: Text('Ride not found'),
          );
        }
        if(query.toString() == ""){
          return Center(
            child: Text('No data'),
          );
        }
        return ListView(
          children: results
              .map<Widget>((a) => Card(
            shadowColor: Color(0xFF6F35A5),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(children: [
                  Text(
                    "Destination: " + a.destination,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Name: " + a.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Phone number: " + "("+a.number.substring(0,3) +")"+a.number.substring(3,10),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Payment: " + a.payment,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Price: \$" + a.price,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " Trip Date: " + new DateFormat.yMMMd().format(new DateTime.fromMillisecondsSinceEpoch(a.datetime)),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Trip Time: " +  new DateFormat.jm().format(DateTime.parse(new DateTime.fromMillisecondsSinceEpoch(a.datetime).toString())),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ])),
          ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: ride,
      builder: (context, AsyncSnapshot<List<PassengerModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No data'),
          );
        }
        final results = snapshot.data
            .where((a) => a.destination.toLowerCase().contains(query.toLowerCase())); //snapshot.data.toSet().contains(a.destination));

        return ListView(
          children: results
              .map<ListTile>((a) => ListTile(
            title: Text(a.destination,style: TextStyle(color: Color(0xFF6F35A5)),),
            leading: Icon(Icons.location_city_rounded),
            onTap: (){
              query = a.destination;
            },))
              .toList(),
        );
      },
    );
  }
}