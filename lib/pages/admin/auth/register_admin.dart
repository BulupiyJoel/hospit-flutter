import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospit/pages/admin/auth/login_admin.dart';
import 'package:hospit/pages/user/auth/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospit/controller/auth_controller.dart';

class RegisterAdmin extends StatefulWidget {
  const RegisterAdmin({super.key});

  @override
  State<RegisterAdmin> createState() => _RegisterAdminState();
}

class _RegisterAdminState extends State<RegisterAdmin> {
  late SharedPreferences pref;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  String? _selectedRole;

  GlobalKey<ScaffoldState> mykey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _usernameController,
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
              TextField(
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _emailController,
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "admin",
                    child: Text("Admin"),
                  ),
                  DropdownMenuItem(
                    value: "user",
                    child: Text("User"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => LoginAdmin()));
                  },
                  child: Text("Already have an account? Log in")),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _selectedRole == null) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                      return; // Exit early if validation fails
                    } else {
                      AuthController authCont = AuthController();
                      String response = await authCont.register(
                          _emailController.text,
                          _passwordController.text,
                          _usernameController.text,
                          _selectedRole!);
                      // Handle response if needed
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
                    'Register',
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
