import 'package:flutter/material.dart';
import 'package:hospit/firebase_options.dart';
// import 'package:hospit/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hospit/pages/admin/home_page.dart';
import 'package:hospit/pages/auth/login.dart';
import 'package:hospit/pages/user/home_page.dart';
// import 'package:hospit/pages/user/home_page.dart';
// import 'package:hospit/pages/user/inscription.dart';

Future<void> main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        primaryColor: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
