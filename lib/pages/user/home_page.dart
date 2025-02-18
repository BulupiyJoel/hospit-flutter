// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/pages/admin/hospital/map_hospital.dart';
import 'package:hospit/pages/auth/login.dart';
import 'package:hospit/pages/user/activity.dart';
import 'package:hospit/pages/user/appointement.dart';
import 'package:hospit/pages/user/inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  late SharedPreferences ref;

  getUsername() async {
    ref = await SharedPreferences.getInstance();
    String? username = ref.getString("username");
    print(username);
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page User'),
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
              leading: const Icon(CupertinoIcons.pen),
              title: const Text('Inscription'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InscriptionPage()));
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.map),
              title: const Text('Map Hopitaux'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const MapHospital()));
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.heart,
                color: Colors.red,
              ),
              title: const Text('Faire don de sang'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const AppointementPage()));
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.person_2),
              title: const Text('Nos activités'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const Activity()));
              },
            ),
            ListTile(
              leading: Icon(getUsername() == null
                  ? Icons.login_outlined
                  : Icons.logout_outlined),
              title:
                  Text(getUsername() == null ? "Se connecter" : "Déconnexion"),
              onTap: () async {
                if (getUsername() == null) {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => const Login()));
                } else {
                  ref = await SharedPreferences.getInstance();
                  await ref.remove("email");
                  await ref.remove("username");
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => const Login()));
                }
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
