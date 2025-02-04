import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:hospit/model/hospital.dart';

class NewHospital extends StatefulWidget {
  const NewHospital({super.key});

  @override
  State<NewHospital> createState() => _NewHospitalState();
}

class _NewHospitalState extends State<NewHospital> {
  //controllers
  final _nomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new Hospital"),
      ),
      body: SingleChildScrollView(
        child: Container(
        margin: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(label: Text("Nom Hopital"),border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10))),
                controller: _nomController,
              ),
              const SizedBox(height:30),
              TextField(
                decoration: InputDecoration(
                    label: Text("Adresse"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _nomController,
              )
              ,
              const SizedBox(height:30),
              TextField(
                decoration: InputDecoration(
                    label: Text("Contact"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _nomController,
              )
              ,
              const SizedBox(height:30),
              TextField(
                decoration: InputDecoration(
                    label: Text("Longitude"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _nomController,
              )
              ,
              const SizedBox(height:30),
              TextField(
                decoration: InputDecoration(
                    label: Text("Latitude"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _nomController,
              ),
              const SizedBox(height: 30,),
              SizedBox(
              width: double.infinity,
                child: ElevatedButton(
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
                  child: const Text(
                    'Submit',
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
