import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:flutter_application_1/signup.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SizedBox(
          height: 400,
          // color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Icon
              Icon(
                Icons.logo_dev,
                size: 200,
                color: Colors.blue,
              ),
              //Bienvenue text
              Text(
                'Bienvenue',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              //full name
              Text(
                'Ms. Maïmouna Traoré',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              //My app text
              Text(
                "C'est ma première application mobile",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (builder) => const SignUpPage())),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (builder) => const SignInPage())),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(.5)),
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
