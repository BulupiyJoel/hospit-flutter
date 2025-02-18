// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:hospit/controller/hospital_controller.dart';
import 'package:hospit/model/hospital.dart';
import 'package:hospit/utils/show_information.dart';
// import 'package:hospit/model/hospital.dart';

class NewHospital extends StatefulWidget {
  const NewHospital({super.key});

  @override
  State<NewHospital> createState() => _NewHospitalState();
}

class _NewHospitalState extends State<NewHospital> {
  //controllers
  late TextEditingController _nomController;
  late TextEditingController _addresseController;
  late TextEditingController _contactController;
  late TextEditingController _longController;
  late TextEditingController _latController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nomController = TextEditingController();
    _addresseController = TextEditingController();
    _contactController = TextEditingController();
    _longController = TextEditingController();
    _latController = TextEditingController();
  }

  FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();
  String? _selectedPhoneNumber;

  getContact() async {
    Contact? contact = await _contactPicker.selectPhoneNumber();
    setState(() {
      _selectedPhoneNumber = contact?.selectedPhoneNumber;
      _contactController.text = removeSpaces(_selectedPhoneNumber!);
      showMessage(context, "Contact selected is : $_selectedPhoneNumber");
    });
  }

  String removeSpaces(String input) {
    return input.replaceAll(RegExp(r'\s+'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un hopital"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    label: const Text("Nom Hopital"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _nomController,
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    label: const Text("Adresse"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _addresseController,
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    label: const Text("Longitude"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _longController,
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    label: const Text("Latitude"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _latController,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // TODO:Implement form submission logic here
                    String name = _nomController.text;
                    String address = _addresseController.text;
                    String contact = _contactController.text;
                    String long = _longController.text;
                    String lat = _latController.text;

                    if (name.isEmpty ||
                        address.isEmpty ||
                        contact.isEmpty ||
                        long.isEmpty ||
                        lat.isEmpty) {
                      showMessage(context, "Aucun champ ne peut etre vide!");
                    }

                    Hospital hospital = Hospital(
                        nom: name,
                        addresse: address,
                        contact: contact,
                        longitude: long,
                        latitude: lat);

                    HospitalController hospitalController =
                        HospitalController();
                    String response = await hospitalController.create(hospital);
                    showMessage(context, response);
                    _nomController.clear();
                    _addresseController.clear();
                    _contactController.clear();
                    _longController.clear();
                    _latController.clear();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
