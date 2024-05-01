// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/affichier.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/ajouter.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/supprimier.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Admin",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor:
            Colors.blueAccent, // Couleur de la barre d'applications
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AjouterEtudiant()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Ajouter un étudiant',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuppEtudiant()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Supprimer un étudiant',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AffichierEtud()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Afficher les étudiants',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navigatorBarFunction(),
    );
  }
}

Widget navigatorBarFunction() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.blueAccent,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white.withOpacity(0.6),
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.people_outline),
        label: 'Étudiants',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        label: 'Enseignants',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Profil',
      ),
    ],
  );
}
