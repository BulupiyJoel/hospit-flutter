import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:image_picker/image_picker.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  // Controllers for input fields
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _groupeSanguinController =
      TextEditingController();
  final TextEditingController _electrophoreseController =
      TextEditingController();

  // Image manipulation
  File? _image;
  final _imagePicker = ImagePicker();

  Future<void> getImage() async {
    XFile? xFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 100,
        maxHeight: 100,
        imageQuality: 95);

    setState(() {
      if (xFile != null) {
        _image = File(xFile.path);
      }
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
      showMessage("Contact selected is : $_selectedPhoneNumber");
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

  Future<void> setGroupSanguin(value) async {
    setState(() {
      _groupeSanguinController.text = value;
    });
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

  Future<void> setElectrophorese(value) async {
    setState(() {
      _electrophoreseController.text = value;
    });
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
                child: _image == null
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("images/camera.png"),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(_image!),
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
              value: 'M',
              items: const [
                DropdownMenuItem(value: 'M', child: Text('Male')),
                DropdownMenuItem(value: 'F', child: Text('Female')),
              ],
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
                  labelText: 'Group sanguin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: "O+",
                items: groupSanguin
                    .map((group) => DropdownMenuItem<String>(
                        value: group, child: Text(group)))
                    .toList(),
                onChanged: (value) {
                  setGroupSanguin(value!);
                }),
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
                value: "AA",
                items: electrophorese
                    .map((group) => DropdownMenuItem<String>(
                        value: group, child: Text(group)))
                    .toList(),
                onChanged: (value) {
                  setElectrophorese(value!);
                }),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement form submission logic here
                // This should include validation of input fields,
                // and sending the data to the server or saving it locally.
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
