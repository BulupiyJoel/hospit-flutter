import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  late SharedPreferences pref;

  Future<String> register(
      String email, String password, String nom) async {
    String rep = "Problèmes rencontrés: ";
    try {
      // user avec tous les droits d'accès
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      firebaseFirestore
          .collection("users")
          .doc(uid)
          .set({"username": nom, "email": email, "role": "user"});
      rep = "Successfully";
    } catch (e) {
      print(e.toString());
      rep = "Error: ${e.toString()}";
    }
    return rep;
  }

Future<String> seConnecterMailPassword(String email, String password) async {
    String response = "Erreur inconnue"; // Default response

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;

      // Récupérer les infos de l'utilisateur depuis Firestore
      DocumentSnapshot userDoc =
          await firebaseFirestore.collection("users").doc(uid).get();

      if (userDoc.exists) {
        String username = userDoc["username"] ?? "Utilisateur";
        String role = userDoc["role"]; // Default role if missing

        // Stocker les infos en cache
        pref = await SharedPreferences.getInstance();
        await pref.setString('email', email);
        await pref.setString('username', username);
        await pref.setString('role', role);

        response = (role == "admin") ? "admin" : "user";
      } else {
        response = "Utilisateur introuvable";
      }
    } catch (e) {
      print("Exception: $e");
      response = "Erreur: ${e.toString()}"; // More descriptive error
    }

    return response;
  }

}
