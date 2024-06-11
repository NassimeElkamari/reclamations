 // Importez la page d'accueil de l'admin
// ignore_for_file: prefer_const_constructors, unused_import, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20admin/navigatorBarAdmi.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Forgot_password_old.dart';// Importez la page de récupération du mot de passe
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Home_enseignant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignInEnseignant extends StatefulWidget {
  const SignInEnseignant({Key? key}) : super(key: key);

  @override
  _SignInEnseignantState createState() => _SignInEnseignantState();
}

class _SignInEnseignantState extends State<SignInEnseignant> {
 TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formSignInKey = GlobalKey<FormState>();
  

 

 Future<void> _signIn(BuildContext context) async {
  try {
    // Recherche dans la collection 'admin'
    final adminQuery = await FirebaseFirestore.instance
        .collection('admin')
        .where('email', isEqualTo: emailAddress.text)
        .where('password', isEqualTo: password.text)
        .get();

    // Recherche dans la collection 'enseignants'
    final enseignantQuery = await FirebaseFirestore.instance
        .collection('enseignants')
        .where('email', isEqualTo: emailAddress.text)
        .where('password', isEqualTo: password.text)
        .get();

    // Redirection selon le type d'utilisateur
    if (adminQuery.docs.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigatorBarAdmin()),
      );
    } else if (enseignantQuery.docs.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeEnseignant()),
      );
    } else {
      // Aucun utilisateur trouvé dans les deux collections
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Erreur',
        desc: 'Aucun utilisateur trouvé pour cet email ou mot de passe incorrect.',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  } catch (e) {
    print('Error: $e');
    // Gérer les erreurs ici
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 87, 118, 184),
      body: Column(
        children: [
          SizedBox(height: 38),
          Row(
            children: [
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            width: double.infinity,
            child: Center(
              child: Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 214, 228, 255),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 1, left: 40),
                        child: Image.asset(
                          "images/login.png",
                          height: 260,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: emailAddress,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                          ),
                          hintText: 'Entrez votre Email',
                          hintStyle: TextStyle(color: Color.fromARGB(66, 0, 8, 53)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(31, 2, 19, 56)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(31, 1, 4, 51)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        controller: password,
                        onChanged: (value) {},
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            'Mot de passe',
                            style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                          ),
                          hintText: 'Entrez votre mot de passe',
                          hintStyle: TextStyle(color: Color.fromARGB(31, 2, 19, 56)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(31, 1, 4, 51)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordOld()),
                              );
                            },
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 115, 124, 163),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formSignInKey.currentState?.validate() ?? false) {
                              await _signIn(context);
                            }
                          },
                          child: Text('Se connecter'),
                        ),
                      ),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}