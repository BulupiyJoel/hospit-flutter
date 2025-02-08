import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {

  late SharedPreferences pref;

  Future<String> register(
      String email, String password, String nom, String role) async {
    String rep = "Problèmes rencontrés: ";
    try {
      // user avec tous les droits d'accès
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      firebaseFirestore
          .collection("users")
          .doc(uid)
          .set({"username": nom, "email": email, "role": role});
      rep = "Successfully";
    } catch (e) {
      print(e.toString());
      rep = "Error: ${e.toString()}";

    }
    return rep;
  }

  Future<String> seConnecterMailPassword(String email, String password) async {
    String statut = "";

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      statut = "accès autorisé";

      pref = await SharedPreferences.getInstance();
      await pref.setString('email', email);
        } catch (e) {
      print("exception:$e");
      statut = e.toString();
    }

    return statut;
  }
}
