import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/pages/user/home_page.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(50),
        child: Column(
          children: [
            const Icon(
              CupertinoIcons.add_circled,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(hintText: "Username"),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePageUser()));
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
