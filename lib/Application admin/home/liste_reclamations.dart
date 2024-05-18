// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/reclamation_details.dart';

enum SortingOrder { ascending, descending }

class ListeDesReclamations extends StatefulWidget {
  const ListeDesReclamations({Key? key}) : super(key: key);

  @override
  State<ListeDesReclamations> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListeDesReclamations> {
  final TextEditingController _searchController = TextEditingController();
  SortingOrder sortingOrder = SortingOrder.descending;
  bool showResolved = true; // Afficher initialement les réclamations traitées

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
