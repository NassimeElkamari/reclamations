import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Enseignant extends StatefulWidget {
  const Home_Enseignant({super.key});

  @override
  State<Home_Enseignant> createState() => _Home_EnseignantState();
}

class _Home_EnseignantState extends State<Home_Enseignant> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? email;

  // Fonction pour obtenir l'email du professeur connecté à partir de SharedPreferences
  Future<void> _loadEmailProfessorConnecte() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailProfConnecte = prefs.getString('emailProfConnecte');
    if (emailProfConnecte != null) {
      setState(() {
        this.email = emailProfConnecte;
      });
    } else {
      print('No email found in SharedPreferences');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEmailProfessorConnecte(); // Charger l'email du professeur connecté lors de l'initialisation de l'état
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil Enseignant"),
      ),
      body: Center(
        child: email != null 
            ? Text("Email du professeur connecté: $email")
            : CircularProgressIndicator(), // Afficher un indicateur de progression pendant le chargement de l'email
      ),
    );
  }
}
