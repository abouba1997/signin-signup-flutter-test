import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';

import 'user.dart';
import 'user_storage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
          'Inscription DEV',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.logo_dev,
                  size: 200,
                  color: Colors.blue,
                ),
                const Text(
                  'Inscription',
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
                  onPressed: () => _signUp(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    'Inscription',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signUp(context) async {
    if (_formKey.currentState!.validate()) {
      // Creation d'une instance de UserStorage
      UserStorage userStorage = UserStorage();
      // Lecture des utilisateurs existants
      List<User> existingUsers = await userStorage.readUserData();

      // Verifie si le nouvel utilisateur existe deja
      bool usernameExists = existingUsers
          .any((user) => user.username == _usernameController.text);

      if (!usernameExists) {
        // Cree le nouvel utilisateur
        final newUser = User(
          username: _usernameController.text,
          password: _passwordController.text,
        );

        // Ajoute le nouvel utilisateur
        existingUsers.add(newUser);

        // Reecris la liste des utilisateurs
        await userStorage.writeUserData(existingUsers);

        // Affiche un petit Snackbar de notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Utilisateur enregistre avec succes!'),
            duration: Duration(seconds: 4),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ce nom d\'utilisateur existe. Connectez-vous!'),
            duration: Duration(seconds: 4),
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
