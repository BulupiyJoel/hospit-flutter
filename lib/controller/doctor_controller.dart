import 'package:hospit/model/doctor_model.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:uuid/uuid.dart';

class DoctorController {
  Future<String> create(Doctor doctor) async {
    String id = const Uuid().v4().toString();
    try {
      firebaseFirestore.collection("doctor").doc(id).set(
          {"id": id, "name": doctor.name, "speciality": doctor.speciality});

      return "Doctor created successfully";
    } catch (e) {
      return "Error on create doctor : ${e.toString()}";
    }
  }
}
