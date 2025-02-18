import 'package:hospit/model/hospital.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:uuid/uuid.dart';

class HospitalController {
  final String apiKey = "mH98nGfJkmC2BhMSQbbmAM8HY4Z5tVvu";

  Future<String> create(Hospital hospital) async {
    String id = const Uuid().v4().toString();
    try {
      firebaseFirestore.collection("hospital").doc(id).set({
        "id": id,
        "name": hospital.nom,
        "address": hospital.addresse,
        "contact": hospital.contact,
        "long": hospital.longitude,
        "lat": hospital.latitude
      });
      return "OK!";
    } catch (e) {
      return "Error on create doctor : ${e.toString()}";
    }
  }

}
