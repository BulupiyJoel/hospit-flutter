import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/model/hospital.dart';

class ListHospital extends StatefulWidget {
  const ListHospital({super.key});

  @override
  State<ListHospital> createState() => _ListHospitalState();
}

class _ListHospitalState extends State<ListHospital> {
  List<Hospital> hospitals = [
    Hospital(
      nom: 'Hospital A',
      addresse: '123 Main St',
      contact: '123-456-7890',
      longitude: '40.712776',
      latitude: '-74.005974',
    ),
    Hospital(
      nom: 'Hospital B',
      addresse: '456 Elm St',
      contact: '987-654-3210',
      longitude: '34.052235',
      latitude: '-118.243683',
    ),
    Hospital(
      nom: 'Hospital C',
      addresse: '789 Oak St',
      contact: '555-555-5555',
      longitude: '41.878113',
      latitude: '-87.629799',
    ),
    Hospital(
      nom: 'Hospital D',
      addresse: '101 Pine St',
      contact: '444-444-4444',
      longitude: '29.760427',
      latitude: '-95.369804',
    ),
    Hospital(
      nom: 'Hospital E',
      addresse: '202 Maple St',
      contact: '333-333-3333',
      longitude: '39.739236',
      latitude: '-104.990251',
    ),
    Hospital(
      nom: 'Hospital F',
      addresse: '303 Birch St',
      contact: '222-222-2222',
      longitude: '32.776665',
      latitude: '-96.796989',
    ),
    Hospital(
      nom: 'Hospital G',
      addresse: '404 Cedar St',
      contact: '111-111-1111',
      longitude: '37.774929',
      latitude: '-122.419418',
    ),
    Hospital(
      nom: 'Hospital H',
      addresse: '505 Spruce St',
      contact: '666-666-6666',
      longitude: '47.606209',
      latitude: '-122.332069',
    ),
    Hospital(
      nom: 'Hospital I',
      addresse: '606 Willow St',
      contact: '777-777-7777',
      longitude: '38.907192',
      latitude: '-77.036873',
    ),
    Hospital(
      nom: 'Hospital J',
      addresse: '707 Ash St',
      contact: '888-888-8888',
      longitude: '42.360081',
      latitude: '-71.058884',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hopital Portail"),
      ),
      body: Column(
        children: [
          Expanded(
            // Wrap ListView in Expanded
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        child: Icon(
                      CupertinoIcons.heart_circle,
                      color: Colors.red,
                    )),
                    title: Text(hospitals[index].nom),
                    subtitle: Text(hospitals[index].contact +
                        " | " +
                        hospitals[index].addresse),
                  ),
                );
              },
              itemCount: hospitals.length,
            ),
          ),
        ],
      ),
    );
  }
}
