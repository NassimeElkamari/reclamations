// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Liste_des_reclamations extends StatefulWidget {
  const Liste_des_reclamations({super.key});

  @override
  State<Liste_des_reclamations> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Liste_des_reclamations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "     Réclamations",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          backgroundColor: Color.fromARGB(255, 50, 93, 150),
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
        body: Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 10, 30, 97),
                Color.fromARGB(255, 101, 162, 243),
              ],
            ),
          ),
        ));
  }
}
