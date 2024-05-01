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
        title: Center(
          child: Text(
            "Home Admin",
            style: TextStyle(
                fontSize: 35, color: Color.fromARGB(255, 229, 232, 238)),
          ),
        ),
        backgroundColor: Color.fromRGBO(89, 139, 231, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AjouterEtudiant()));
            },
            child: Text('Ajouter un étudiant'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SuppEtudiant()));
            },
            child: Text('Supprimer un étudiant'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AffichierEtud()));
            },
            child: Text('Afficher les étudiants'),
          ),
        ],
      ),
      
      bottomNavigationBar: navigatorBarFunction(),
    );
  }
}

Widget navigatorBarFunction() {
  return NavigationBar(
    height: 70,
    destinations: [
      NavigationDestination(
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Color.fromARGB(255, 16, 47, 105),
        ),
        selectedIcon: Icon(Icons.groups),
        label: 'Étudiants',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.group,
          color: Color.fromARGB(255, 16, 47, 105),
        ),
        selectedIcon: Icon(Icons.groups),
        label: 'Enseignants',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.account_circle,
          color: Color.fromARGB(255, 16, 47, 105),
        ),
        selectedIcon: Icon(Icons.account_circle),
        label: 'Profil',
      ),
    ],
  );
}
