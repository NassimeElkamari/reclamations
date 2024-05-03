import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/sign_in_enseignant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 62, 114, 226),
              Color.fromARGB(255, 255, 237, 255),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              "images/LOGO fs.png",
              height: 130,
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInEnseignant()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 253, 239, 255),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Color.fromARGB(255, 112, 10, 104)),
                ),
                child: const Center(
                  child: Text(
                    'ESPACE ENSEIGNANT',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                      wordSpacing: 6,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 4, 31, 119),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 253, 239, 255),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Color.fromARGB(255, 112, 10, 104)),
                ),
                child: const Center(
                  child: Text(
                    'ESPACE ETUDIANT',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                      wordSpacing: 5,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 4, 31, 119),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
