import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/pages/admin/auth/login_admin.dart';
import 'package:hospit/pages/admin/donnor/list_donnor.dart';
import 'package:hospit/pages/admin/hospital/list_hospital.dart';
import 'package:hospit/pages/admin/hospital/new_hospital.dart';
import 'package:hospit/pages/user/inscription.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page Admin'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(21, 33, 149, 243),
              ),
              child: Image.asset('images/icon.png'),
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.house_alt,
                color: Colors.red,
              ),
              title: const Text('Nouvel Hopital'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewHospital()));
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.list_bullet,
                color: Colors.red,
              ),
              title: const Text('Hopitaux'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ListHospital()));
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.heart_circle,
                color: Colors.red,
              ),
              title: const Text('Medecin'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.person_2,
                color: Colors.red,
              ),
              title: const Text('Liste donneurs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ListDonnor()));
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.person,
                color: Colors.red,
              ),
              title: const Text('Se connecter'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => LoginAdmin()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Icon(
          CupertinoIcons.add_circled,
          size: 100,
          color: Colors.red,
        ),
      ),
    );
  }
}
