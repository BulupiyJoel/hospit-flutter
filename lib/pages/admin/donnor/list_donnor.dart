import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/utils/firebase_config.dart';

class ListDonnor extends StatefulWidget {
  const ListDonnor({super.key});

  @override
  State<ListDonnor> createState() => _ListDonnorState();
}

class _ListDonnorState extends State<ListDonnor> {
  final ListDonnor = firebaseFirestore.collection("donor").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ListDonnor,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "List Donneur",
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
                  "List Donneur",
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
              title: const Text("List Donneur"),
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
                            leading: Icon(
                              CupertinoIcons.person_2_square_stack,
                            ),
                            title: Text(
                                "${snapshots.data!.docs[index]["nom"]!} ${snapshots.data!.docs[index]["prenom"]!}"),
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
        });
  }
}
