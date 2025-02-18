import 'package:flutter/material.dart';
import 'package:hospit/pages/auth/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor)),
                child: const Text(
                  "Admin Portal",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login()));
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor)),
                child: const Text(
                  "User Portal",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
