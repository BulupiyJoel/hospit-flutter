import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/controller/doctor_controller.dart';
import 'package:hospit/model/doctor_model.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:hospit/utils/show_information.dart';

class MedecinPage extends StatefulWidget {
  const MedecinPage({super.key});

  @override
  State<MedecinPage> createState() => _MedecinPageState();
}

class _MedecinPageState extends State<MedecinPage> {
  //controller
  late TextEditingController _nomController;
  late TextEditingController _specialiteController;

  //fetch doctors
  final listDoctors = firebaseFirestore.collection("doctor").snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nomController = TextEditingController();
    _specialiteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: listDoctors,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Doctors"),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: const Center(
                child: Text("Aucun medecin trouvé"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Doctors"),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: const Center(
                child: Row(
                  spacing: 2.0,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.lightGreen,
                    ),
                    Text("Patientez...")
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Portail Medecin'),
            ),
            body: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _nomController,
                    decoration: InputDecoration(
                        labelText: "Nom",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _specialiteController,
                    decoration: InputDecoration(
                        labelText: "Specialité",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // TODO: Implement form submission logic here
                        // This should include validation of input fields,
                        // and sending the data to the server or saving it locally.
                        String name = _nomController.text;
                        String speciality = _specialiteController.text;

                        if (name.isEmpty || speciality.isEmpty) {
                          showMessage(
                              context, "Les champs ne peuvent pas etre vides");
                        }
                        Doctor doctor = Doctor(
                          name: name,
                          speciality: speciality,
                        );

                        DoctorController doctorController = DoctorController();
                        String response = await doctorController.create(doctor);
                        _nomController.clear();
                        _specialiteController.clear();
                        
                        showMessage(context, response);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Valider',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                leading: const Icon(
                                  CupertinoIcons.heart_circle_fill,
                                  color: Colors.red,
                                ),
                                title: Text(snapshot.data!.docs[index]["name"]),
                                subtitle: Text(
                                    snapshot.data!.docs[index]["speciality"]),
                              ),
                            );
                          }))
                ],
              ),
            ),
          );
        });
  }
}
