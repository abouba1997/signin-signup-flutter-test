import 'package:flutter/material.dart';
import 'package:flutter_application_1/students_page.dart';
import 'package:flutter_application_1/user.dart';
import 'package:collection/collection.dart';

import 'package:flutter_application_1/user_storage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Authentification DEV',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      body: SafeArea(
        child: Center(
            child: SizedBox(
          height: 600,
          // color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Icon
              const Icon(
                Icons.logo_dev,
                size: 200,
                color: Colors.blue,
              ),
              //Bienvenue text
              const Text(
                'Authentification',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Nom d'utilisateur"),
                            hintText: 'ex: mamadou',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.lightBlueAccent,
                                  style: BorderStyle.none,
                                )),
                          ),
                          controller: _usernameController,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Mot de passe"),
                            hintText: '********',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.lightBlueAccent,
                                  style: BorderStyle.none,
                                )),
                          ),
                          controller: _passwordController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _signIn(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  "Connexion",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  _signIn(context) async {
    if (_formKey.currentState!.validate()) {
      // Creation d'une instance de UserStorage
      UserStorage userStorage = UserStorage();
      // Lecture des utilisateurs existants
      List<User> usersList = await userStorage.readUserData();

      //Verifie si l'utilisateur exisr
      final existUser = usersList.firstWhereOrNull(
        (element) =>
            element.username == _usernameController.text &&
            element.password == _passwordController.text,
      );

      if (existUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentsPage(),
          ),
        );
      } else {
        // User not found, show a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Utilisateur ou mot de passe incorrect.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Le formulaire n\'est pas valide'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }
}
