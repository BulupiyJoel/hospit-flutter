import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/controller/appointment_controller.dart';
import 'package:hospit/model/appointment.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:hospit/utils/show_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointementPage extends StatefulWidget {
  const AppointementPage({super.key});

  @override
  State<AppointementPage> createState() => _AppointementPageState();
}

class _AppointementPageState extends State<AppointementPage> {
  final AppointementPage = firebaseFirestore.collection("hospital").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AppointementPage,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "List Hopital",
                  style: TextStyle(
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 224, 224, 255),
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: const Row(
                children: [Text("Aucune donnée...")],
              ),
            );
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "List Hopital",
                  style: TextStyle(
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 224, 224, 255),
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: const Row(
                children: [
                  CircularProgressIndicator(),
                  Text("veillez patienter...")
                ],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Faire don"),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Expanded(
                    // Wrap ListView in Expanded
                    child: ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(
                                "Hopital: ${snapshots.data!.docs[index]["name"]!}"),
                            subtitle: Text(
                                "Contact : ${snapshots.data!.docs[index]['contact']} \nAddresse : ${snapshots.data!.docs[index]['address']}"),
                            trailing: TextButton(
                              child: Text(
                                "Rendez-vous",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).primaryColor,
                              )),
                              onPressed: () async {
                                late SharedPreferences pref;
                                pref = await SharedPreferences.getInstance();

                                String? patient = pref.getString("username");
                                String hopital =
                                    snapshots.data!.docs[index]["name"]!;

                                Appointment appointment = Appointment(
                                    patient: patient, hopital: hopital);
                                AppointmentController appointmentController =
                                    AppointmentController();
                                String response = await appointmentController
                                    .createAppointment(appointment);

                                showMessage(context, response);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
