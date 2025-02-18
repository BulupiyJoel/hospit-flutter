import 'package:hospit/model/donnor.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:uuid/uuid.dart';

class DonorController {
  Future<String> create(Donnor donor) async {
    try {
      String id = const Uuid().v4().toString();

      firebaseFirestore.collection("donor").doc(id).set({
        "name": donor.nom,
        "lastname": donor.prenom,
        "sexe": donor.sexe,
        "contact": donor.contact,
        "group_sanguin": donor.groupeSanguin,
        "electrophorese": donor.electrophorese
      });

      return "Inscription reussie";
    } catch (e) {
      return "Error : ${e.toString()}";
    }
  }
}
