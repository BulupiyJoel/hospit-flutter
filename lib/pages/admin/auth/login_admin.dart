import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/controller/auth_controller.dart';
import 'package:hospit/pages/admin/auth/register_admin.dart';
import 'package:hospit/pages/admin/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  late SharedPreferences pref;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  GlobalKey<ScaffoldState> mykey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
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
              const SizedBox(height: 30),const SizedBox(height: 30),
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
                            builder: (builder) => RegisterAdmin()));
                  },
                  child: Text("Pas de compte ? Créer")),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // TODO: Implement form submission logic here
                    // This should include validation of input fields,
                    // and sending the data to the server or saving it locally.
                    AuthController auth = AuthController();
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    String statut =
                        await auth.seConnecterMailPassword(email, password);
                    print("statut : $statut");

                    if (statut == "accès autorisé") {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => HomePageAdmin()));
                    } else {
                      print("Statut : $statut");
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
