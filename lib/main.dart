/// ignore_for_file: unused_import

import 'package:application_gestion_des_reclamations_pfe/Application%20admin/authenAdmin.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/homeAdmin.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/etudiant_details.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Correct import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        /* 'HomeEnseignant': (context) => HomeEnseignant(),
    'LoginEnseignant': (context) => SignInEnseignant(),
    'HomeEtudiant': (context) => NavigatorBarEtudiant(),*/
      },
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: AdminHome(),
    );
  }
}

void initState() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('=================================User is currently signed out!');
    } else {
      print('==================================User is signed in!');
    }
  });
}
