import 'package:hospit/model/appointment.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:uuid/uuid.dart';

class AppointmentController {
  Future<String> createAppointment(Appointment appointment) async {
    try {
      String id = const Uuid().v4().toString();
      firebaseFirestore.collection("appointment").doc(id).set({
        "id": id,
        "patient": appointment.patient,
        "hopital": appointment.hopital
      });

      return "Rendez-vous pris";
    } catch (e) {
      return e.toString();
    }
  }
}
