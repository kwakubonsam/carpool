import 'package:carpool/constants.dart';
import 'package:carpool/widgets/RideCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carpool/services/database.dart';
import 'package:carpool/models/passengermodel.dart';
import 'package:carpool/services/search.dart';
import 'package:intl/intl.dart';

class Passenger extends StatefulWidget {
  const Passenger({Key key}) : super(key: key);
  @override
  _PassengerState createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
  Widget build(BuildContext context) {
    CollectionReference rides = FirebaseFirestore.instance.collection('ridz');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rides"),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: RideSearch(Database(rides: rides).streamRides()));
              },
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: Database(rides: rides).streamRides(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PassengerModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data.isEmpty) {
                    return const Center(
                      child: Text(
                        "There's currently no rides",
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return RideCard(
                        rides: rides,
                        ride: snapshot.data[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("loading..."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


