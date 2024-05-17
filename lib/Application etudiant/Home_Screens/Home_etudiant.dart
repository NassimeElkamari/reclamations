// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/homebody_etudiant.dart';
import 'package:flutter/material.dart';

class HomeEtudiant extends StatefulWidget {
  const HomeEtudiant({super.key});

  @override
  State<HomeEtudiant> createState() => _HomeEtudiantState();
}

class _HomeEtudiantState extends State<HomeEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: homeAppBar(),
      body: HomeBodyEtudiant(),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 168, 198, 255),
      title: Center(
          child: Text(
        'Acceuil',
        style: TextStyle(
            fontSize: 35, color: const Color.fromARGB(255, 255, 255, 255)),
      )),
    );
  }
}
