// ignore_for_file: unused_import

import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/authentification.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/sign_in_enseignant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/AjouterReclamation.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Login.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

          // primaryColor:  Color.fromARGB(95, 20, 80, 243),

          ),
      debugShowCheckedModeBanner: false,


      home:Authentification(),

 
      

    );
  }
}
