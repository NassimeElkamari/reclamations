// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/signup.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/entrer_le_code.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ForgotPasswordEtudiant extends StatefulWidget {
  const ForgotPasswordEtudiant({super.key});

  @override
  _ForgotPasswordEtudiantState createState() => _ForgotPasswordEtudiantState();
}

class _ForgotPasswordEtudiantState extends State<ForgotPasswordEtudiant> {
  final TextEditingController emailController = TextEditingController();
  bool isValidEmail = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _validateEmail(String value) {
    setState(() {
      isValidEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
    });
  }
void _redirectToAnotherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  EntrerCode()),
    );
  }

  void _onPressed() {
    _sendPasswordResetEmail();
    _redirectToAnotherPage();
  }
  Future<void> _sendPasswordResetEmail() async {
    String email = emailController.text;

    if (isValidEmail) {
      try {
        // Vérifier si l'e-mail existe dans la collection etudiantsActives
        QuerySnapshot snapshot = await _firestore
            .collection('etudiantsActives')
            .where('email', isEqualTo: email)
            .get();

        if (snapshot.docs.isNotEmpty) {
          // Envoyer le lien de réinitialisation de mot de passe via un service d'e-mail
          await _sendEmail(email); // Utilisation de la méthode _sendEmail ici
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Un email de réinitialisation de mot de passe a été envoyé.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("L'adresse e-mail n'existe pas dans la base de données."),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Une erreur s'est produite : $e"),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Veuillez entrer une adresse e-mail valide."),
      ));
    }
  }

  Future<void> _sendEmail(String recipientEmail) async {
    String username = 'your-email@example.com';
    String password = 'your-email-password';
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Application E_réclamation ')
      ..recipients.add(recipientEmail)
      ..subject = 'Réinitialisation de votre mot de passe'
      ..text = 'Cliquez sur ce lien pour réinitialiser votre mot de passe : <lien>';

    try {
      final sendReport = await send(message, smtpServer);
      // ignore: prefer_interpolation_to_compose_strings
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Center(
                child: Image.asset(
                  'images/loocked.png',
                  width: 150.0,
                  height: 100.0,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "   Forget  ",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 40, 22, 104),
                ),
              ),
              Text(
                "  Password ",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 40, 22, 104),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Entrer votre adresse email avec laquelle ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 26, 11, 158),
                  ),
                ),
              ),
              Text(
                "vous allez recevoir un code.",
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 26, 11, 158),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(23.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Icon(
                      Icons.check,
                      color: isValidEmail
                          ? Colors.green
                          : Color.fromARGB(192, 6, 56, 78),
                    ),
                    labelText: "Gmail",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 3, 78),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  onChanged: _validateEmail,
                ),
              ),
              ElevatedButton(
                onPressed: _onPressed,
                
                child: Text(
                  "ENVOYER",
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 147, 236, 120),
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // au centre
                children: [
                  Text(
                    "Doesn't have account yet ? ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 26, 11, 158), fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 40, 22, 104),
                          fontSize: 19,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
