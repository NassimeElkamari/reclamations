// ignore_for_file: prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20commune/logo.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Home_enseignant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/profile.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Correct import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Welcome': (context) => WelcomeScreen(),
        'Welcome': (context) => WelcomeScreen(),
        '/loginetudiant': (context) => Login(),
        // 'HomeEnseignant': (context) => HomeEnseignant(),
        //'LoginEnseignant': (context) => SignInEnseignant(),
        //'HomeEtudiant': (context) => NavigatorBarEtudiant(),
      },
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: LogoScreen(),
    );
  }
}
