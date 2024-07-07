// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsReclamation extends StatelessWidget {
  final DocumentSnapshot document;

  const DetailsReclamation({Key? key, required this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool status = document['status'];
    final Timestamp timestamp = document['date'];
    final DateTime date = timestamp.toDate();
    

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // Revenir à la page précédente avec la barre de navigation actuelle
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "Détails de la réclamation",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        Color.fromARGB(255, 55, 105, 172), // Couleur de la bordure
                    width: 1, // Épaisseur de la bordure
                  ),
                  borderRadius: BorderRadius.circular(10), // Bord arrondi
                ),
                child: Center(
                  child: Text(
                    'Sujet: ${document['sujet']}',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 105, 172),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  Text(
                    'Etudiant:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 105, 172),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 55, 105, 172), // Couleur de la bordure
                        width: 1, // Épaisseur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(10), // Bord arrondi
                    ),
                    child: Center(
                      child: Text(
                        ' ${document['nomEtudiant']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 55, 105, 172),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Enseignant:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 105, 172),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 55, 105, 172), // Couleur de la bordure
                        width: 1, // Épaisseur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(10), // Bord arrondi
                    ),
                    child: Center(
                      child: Text(
                        ' ${document['nomEnseignant']}',
                        style: TextStyle(
                          fontSize:16,
                          color: Color.fromARGB(255, 55, 105, 172),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Status:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 105, 172),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 55, 105, 172), // Couleur de la bordure
                        width: 1, // Épaisseur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(10), // Bord arrondi
                    ),
                    child: Center(
                      child: Text(
                        '${status ? 'Traité' : 'Non traité'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: status ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Date  :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 105, 172),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:Color.fromARGB(255, 55, 105, 172),// Couleur de la bordure
                        width: 1, // Épaisseur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(10), // Bord arrondi
                    ),
                    child: Center(
                      child: Text(
                        ' ${DateFormat('dd/MM/yyyy   HH:mm').format(date)}',
                        style: TextStyle(
                          fontSize: 16,
                           color:Color.fromARGB(255, 55, 105, 172),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              
              SizedBox(height: 20),
              Text(
                'Description  :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 55, 105, 172),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 200,
                width:double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 55, 105, 172), // Couleur de la bordure
                    width: 1, // Épaisseur de la bordure
                  ),
                  borderRadius: BorderRadius.circular(10), // Bord arrondi
                ),
                child: Text(
                  '${document['description']}',
                  style: TextStyle(
                    fontSize: 16,
                     color: Color.fromARGB(255, 55, 105, 172),
                  ),
                ),
              ),
            if (document['status'] == true) ...[
  Text(
    'Réponse :',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 55, 105, 172),
    ),
  ),
  SizedBox(
    width: 15,
  ),
  Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(255, 55, 105, 172), // Couleur de la bordure
        width: 1, // Épaisseur de la bordure
      ),
      borderRadius: BorderRadius.circular(10), // Bord arrondi
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0), // Ajout de padding pour améliorer la lisibilité
      child: Text(
        '${document['reponse']}',
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 55, 105, 172),
        ),
      ),
    ),
  ),
  SizedBox(height: 20), // Ajout d'espace en bas pour une meilleure séparation
],

              
            ],
          ),
        ),
      ),
    );
  }
}
