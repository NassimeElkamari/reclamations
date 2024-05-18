// ignore_for_file: prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
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

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('=================================User is currently signed out!');
      } else {
        print('==================================User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Welcome': (context) => WelcomeScreen(),
        // 'HomeEnseignant': (context) => HomeEnseignant(),
        //'LoginEnseignant': (context) => SignInEnseignant(),
        //'HomeEtudiant': (context) => NavigatorBarEtudiant(),
      },
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
