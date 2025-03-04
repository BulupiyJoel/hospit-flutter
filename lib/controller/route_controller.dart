import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospit/model/route.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:uuid/uuid.dart';

class RouteController {
  Future<String> departure(RouteModel route) async {
    String id = const Uuid().v4().toString();

    try {
      await firebaseFirestore.collection("route").doc(id).set({
        "id": id,
        "lat": route.lat,
        "lon": route.lon,
        "state": route.state,
        "timestamp": FieldValue.serverTimestamp(), // Add timestamp field
      });

      return "Departure set successfully";
    } catch (e) {
      return "Error in departure: ${e.toString()}";
    }
  }

  Future<String> arrival(RouteModel route) async {
    String id = const Uuid().v4().toString();

    try {
      await firebaseFirestore.collection("route").doc(id).set({
        "id": id,
        "lat": route.lat,
        "lon": route.lon,
        "state": route.state,
        "timestamp": FieldValue.serverTimestamp(), // Add timestamp field
      });

      return "Arrival set successfully";
    } catch (e) {
      return "Error in arrival: ${e.toString()}";
    }
  }
}
