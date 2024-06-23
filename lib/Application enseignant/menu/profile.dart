// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEnseignant extends StatefulWidget {
  const ProfileEnseignant({super.key});

  @override
  State<ProfileEnseignant> createState() => _ProfileEtudiantState();
}

class _ProfileEtudiantState extends State<ProfileEnseignant> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //liste des fillieres
  List<String> _filieres = [
    'Sciences Mathématiques Appliquées (SMA)',
    'Sciences Mathématiques Informatiques (SMI)',
    'Sciences de la Matière Physique (SMP)',
    'Sciences de la Matière Chimie (SMC)',
    'Sciences de la Vie (SVI)',
    "Sciences de la Terre et de l'Univers (STU)",
  ];

  

  String nom = '';
  String prenom = '';
  String email = '';
  String filiere = '';
  String profileUrl = '';
  String? emailProfessorConnecte = '';


//lafonction initialisation
  @override
  void initState() {
    super.initState();
    _loadEmail(); // Chargement de l'apogée au démarrage de la page
   
  }

  //lafonction de get apoge d etuidant connecte
 
  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailProfessorConnecte = prefs.getString('emailProfConnecte');
    });
  }

//la fonction de deconnexion
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Déconnexion de Firebase Auth
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(
          'emailProfessorConnecte'); // Suppression de l'apogée dans SharedPreferences
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Login()), // Assurez-vous que LoginPage() est correctement importé
      );
      print("connexion reussite !!!!:)  pour " + nom + "  " + prenom);
    } catch (e) {
      print('Erreur lors de la déconnexion : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 84, 132, 196),
        title: Row(children: [
          SizedBox(width: 120),
          Text(
            "Mon profil",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ]),
        
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore
            .collection('enseignants')
            .where('email', isEqualTo: emailProfessorConnecte)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data found for the given apoge."));
          }

          var data = snapshot.data!.docs.first.data();
          nom = data['nom'] ?? '';
          prenom = data['prenom'] ?? '';
          email = (data['email'] ?? '').toString();
          filiere = data['filiere'] ?? '';
          profileUrl = data['profile'] ?? '';
          

         
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                // Photo de profil
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: SizedBox(
                      width: 220,
                      height: 200,
                      child: Image.network(profileUrl)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              SizedBox(height: 15),
              // Bouton pour éditer la photo de profil

              SizedBox(height: 15),
              AfficherInformationEtudiant('Nom', nom, 18, 40),
              AfficherInformationEtudiant('Prenom', prenom, 18, 40),
              AfficherInformationEtudiant('email', email, 18, 40),
              AfficherInformationEtudiant('Filiere', filiere, 18, 65),
              
              SizedBox(height: 20),
              
            ],
          );
        },
      ),
    );
  }

  Padding AfficherInformationEtudiant(
      String label, String valeur, double taille, double toul) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 5),
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 84, 132, 196),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 12),
              height: toul,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 238, 116, 17),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  ' $valeur ',
                  style: TextStyle(
                    fontSize: taille,
                    color: Color.fromARGB(255, 55, 105, 172),
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