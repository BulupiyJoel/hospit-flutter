import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/model/hospital.dart';
import 'package:hospit/utils/firebase_config.dart';

class ListHospital extends StatefulWidget {
  const ListHospital({super.key});

  @override
  State<ListHospital> createState() => _ListHospitalState();
}

class _ListHospitalState extends State<ListHospital> {
  final listHospital = firebaseFirestore.collection("hospital").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: listHospital,
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
            title: const Text("Hopital Portail"),
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
                          leading: const CircleAvatar(
                              child: Icon(
                            CupertinoIcons.heart_circle,
                            color: Colors.red,
                          )),
                          title: Text("Nom : ${snapshots.data!.docs[index]["name"]!}"),
                          subtitle: Text(
                              "Contact : ${snapshots.data!.docs[index]['contact']} \nAddresse : ${snapshots.data!.docs[index]['address']}"),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
