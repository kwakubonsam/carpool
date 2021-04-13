import 'package:carpool/models/passengermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  CollectionReference rides;

  Database({this.rides});
  Stream<List<PassengerModel>> streamRides() {
    try {
      return rides
          .where("time", isGreaterThan: DateTime.now().millisecondsSinceEpoch.toInt())
          .snapshots()
          .map((query) {
        final List<PassengerModel> retVal = <PassengerModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(PassengerModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addRide({String name, String destination, String price, String payment, String number, int time}) async {
    try {
      rides.add({
        "name": name,
        "destination": destination,
        "price": price,
        "payment":payment,
        "number": number,
        "time": time,
      });
    } catch (e) {
      rethrow;
    }
  }

}
