import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/affichier.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/ajouter.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/supprimier.dart';
import 'package:flutter/material.dart';
class Liste_des_etudiants extends StatefulWidget {
  const Liste_des_etudiants({super.key});

  @override
  State<Liste_des_etudiants> createState() => _Liste_des_etudiantsState();
}

class _Liste_des_etudiantsState extends State<Liste_des_etudiants> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Admin",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 39, 45, 55),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              // Ajoutez ici la logique de déconnexion
            },
          ),
        ], // Couleur de la barre d'applications
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
                primary: Color.fromARGB(255, 206, 217, 248),
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
                primary: Color.fromARGB(255, 206, 217, 248),
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
                primary: Color.fromARGB(255, 206, 217, 248),
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
      
    );
}}