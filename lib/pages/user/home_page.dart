import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/pages/user/inscription.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InscriptionPage()));
              },
            ),
            ListTile(
            leading: const Icon(CupertinoIcons.map),
              title: const Text('Map Hospitaux'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.heart,color: Colors.red,),
              title: const Text('Faire don de sang'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.person_2),
              title: const Text('Nos activités'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.person),
              title: const Text('Se connecter'),
              onTap: () {
                Navigator.pop(context);
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
