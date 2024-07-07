// Importations de packages nécessaires
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Forgot_password_old.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Forgot_password.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/Home_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/profile_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/custombuttonauth.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? _selectedFiliere;
  List<String> _filieres = [
    'Sciences Mathématiques Appliquées (SMA)',
    'Sciences Mathématiques Informatiques (SMI)',
    'Sciences de la Matière Physique (SMP)',
    'Sciences de la Matière Chimie (SMC)',
    'Sciences de la Vie (SVI)',
    "Sciences de la Terre et de l'Univers (STU)",
  ];
  TextEditingController nomEntre = TextEditingController();
  TextEditingController prenomEntre = TextEditingController();
  TextEditingController appogeEntre = TextEditingController();
  TextEditingController emailEntre = TextEditingController();
  TextEditingController passwordEntre = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  Future<void> _saveApoge(String apoge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apogeConnecte', apoge);
  }

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('etudiants')
            .where('appoge', isEqualTo: appogeEntre.text)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailEntre.text,
            password: passwordEntre.text,
          );

          await FirebaseFirestore.instance.collection('etudiantsActives').add({
            'nom': nomEntre.text,
            'prenom': prenomEntre.text,
            'apoge': appogeEntre.text,
            'email': emailEntre.text,
            'sexe': "  ",
            'filiere': _selectedFiliere,
            'password': passwordEntre.text
          });

          await _saveApoge(appogeEntre.text);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigatorBarEtudiant()),
          );

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Compte activé avec succès!'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Apogée non trouvé. Veuillez vérifier vos informations.'),
          ));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veuillez remplir les champs obligatoires'),
      ));
    }
  }

  String? apogeConnecte;

  // Validation function to check if the input contains only letters
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Veuillez entrer uniquement des lettres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey, // Assign the form key
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(179, 45, 11, 90),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: const Text("SignUp",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 33, 55, 128),
                        )),
                  ),
                  Container(height: 10),
                  Center(
                    child: const Text(
                        "SignUp To Continue Using The App",
                        style: TextStyle(
                          color: Color.fromARGB(255, 141, 149, 179),
                        )),
                  ),
                  Container(height: 20),
                  const Text(
                    "Nom ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 8),
                  CustomTextForm(
                    hinttext: "Enter votre nom",
                    mycontroller: nomEntre,
                    obscureText: false,
                    validator: _validateName, // Apply the validator
                  ),
                  Container(height: 20),
                  const Text(
                    "Prenom ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 8),
                  CustomTextForm(
                    hinttext: "Enter votre prenom",
                    mycontroller: prenomEntre,
                    obscureText: false,
                    validator: _validateName, // Apply the validator
                  ),
                  Container(height: 20),
                  const Text(
                    "Appoge ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 8),
                  CustomTextForm(
                    hinttext: "Enter votre Appoge",
                    mycontroller: appogeEntre,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ce champ est obligatoire';
                      }
                      return null;
                    },
                  ),
                  Container(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 8),
                  CustomTextForm(
                    hinttext: "Enter Your Email",
                    mycontroller: emailEntre,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ce champ est obligatoire';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  Container(height: 8),
                  Text(
                    "Filière ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 8),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(),
                      color: Color.fromARGB(255, 223, 230, 252),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedFiliere,
                      items: _filieres.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFiliere = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est obligatoire';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 8),
                  CustomTextForm(
                    hinttext: "Enter Your Password",
                    mycontroller: passwordEntre,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ce champ est obligatoire';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit comporter au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                  Container(height: 30),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(255, 33, 55, 128)),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          signUp();
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
