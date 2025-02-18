// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:hospit/controller/donor_controller.dart';
import 'package:hospit/model/donnor.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:hospit/utils/show_information.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  // Controllers for input fields
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _sexeController;
  late TextEditingController _contactController;
  late TextEditingController _groupeSanguinController;
  late TextEditingController _electrophoreseController;
  late TextEditingController _adresseController;

  // Image manipulation
  PlatformFile? pickedFile;
  Future<void> getImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  //Contact picker implementation
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  String? _selectedPhoneNumber;

  getContact() async {
    Contact? contact = await _contactPicker.selectPhoneNumber();
    setState(() {
      _selectedPhoneNumber = contact?.selectedPhoneNumber;
      _contactController.text = _selectedPhoneNumber!;
    });
  }

//Groupes sanguins implementation
  List<String> groupSanguin = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];

  //Upload File to Firebase
  String path = "";
  UploadTask? uploadTask;
  Future uploadFile() async {
    path = '/files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
  }

//Electrophorese implementation
  List<String> electrophorese = [
    "AA",
    "AS",
    "SS",
    "AC",
    "SC",
    "CC",
  ];

  //Sexe
  List<String> sexes = ["M", "F"];

  Future<void> setElectrophorese(value) async {
    setState(() {
      _electrophoreseController.text = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _sexeController = TextEditingController(
        text: sexes.first); // ✅ Prend le premier élément valide
    _groupeSanguinController = TextEditingController(text: groupSanguin.first);
    _electrophoreseController =
        TextEditingController(text: electrophorese.first);
    _adresseController = TextEditingController();
    _contactController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImage();
                },
                child: pickedFile == null
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("images/camera.png"),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          File(pickedFile!.path!),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: _nomController,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: _prenomController,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Sexe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: sexes.contains(_sexeController.text)
                  ? _sexeController.text
                  : null, // ✅ Vérification
              items: sexes.map((sexe) {
                return DropdownMenuItem<String>(
                  value: sexe,
                  child: Text(sexe),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _sexeController.text = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Contact',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _contactController,
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    getContact();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Select",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Groupe sanguin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: groupSanguin.contains(_groupeSanguinController.text)
                  ? _groupeSanguinController.text
                  : null, // ✅ Vérification
              items: groupSanguin.map((group) {
                return DropdownMenuItem<String>(
                  value: group,
                  child: Text(group),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _groupeSanguinController.text = value!;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Electrophorese',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: electrophorese.contains(_electrophoreseController.text)
                    ? _electrophoreseController.text
                    : null,
                items: electrophorese
                    .map((group) => DropdownMenuItem<String>(
                        value: group, child: Text(group)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _electrophoreseController.text = value!;
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Adresse',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: _adresseController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO: Implement form submission logic here
                String name = _nomController.text;
                String lastname = _prenomController.text;
                String sexe = _sexeController.text;
                String contact = _contactController.text;
                String group = _groupeSanguinController.text;
                String elec = _electrophoreseController.text;
                String address = _adresseController.text;

                if (name.isEmpty ||
                    lastname.isEmpty ||
                    sexe.isEmpty ||
                    contact.isEmpty ||
                    group.isEmpty ||
                    elec.isEmpty ||
                    address.isEmpty) {
                  showMessage(context,
                      "Nom : ${name}/Prenom : ${lastname}/Sexe : ${sexe}/Contact : ${contact}/Sang : ${group}/Elec : ${elec}/Addr : ${address} Aucun champ ne peut etre vide");
                } else {
                  Donnor donor = Donnor(
                    nom: name,
                    prenom: lastname,
                    sexe: sexe,
                    contact: contact,
                    groupeSanguin: group,
                    electrophorese: elec,
                    address: address,
                  );

                  DonorController donorController = DonorController();
                  String response = await donorController.create(donor);

                  showMessage(context, response);

                  _nomController.clear();
                  _prenomController.clear();
                  _sexeController.clear();
                  _contactController.clear();
                  _groupeSanguinController.clear();
                  _electrophoreseController.clear();
                  _adresseController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Envoyer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
