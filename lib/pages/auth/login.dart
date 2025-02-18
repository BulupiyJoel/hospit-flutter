import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/controller/auth_controller.dart';
import 'package:hospit/pages/auth/register.dart';
import 'package:hospit/pages/admin/home_page.dart';
import 'package:hospit/pages/user/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences pref;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  GlobalKey<ScaffoldState> mykey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mykey,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Icon(
                CupertinoIcons.add_circled,
                size: 100,
                color: Colors.red,
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _emailController,
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => Register()));
                  },
                  child: Text("Pas de compte ? Créer")),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    AuthController auth = AuthController();
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    // Récupérer le statut de connexion
                    String statut = await auth.seConnecterMailPassword(email, password);
                    print("Statut : $statut");

                    // Récupérer le rôle stocké
                    pref = await SharedPreferences.getInstance();
                    String? role = pref.getString("role");

                    // Vérifier le rôle et rediriger vers la bonne page
                    if (role == "admin") {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePageAdmin()));
                    } else {
                    Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePageUser()));
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
                    'Connexion',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
