// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsEtudiant extends StatelessWidget {
  final String documentId;

  const DetailsEtudiant({Key? key, required this.documentId}) : super(key: key);

  Widget buildInfoContainer(String label, String value) {
    return Container(
      margin: EdgeInsets.only(left :8,right:8,bottom: 8,top: 9),
      height:60 ,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 4, 19, 105),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '$label: $value',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 4, 19, 105),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            "Détails Étudiant",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 51, 128),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('etudiantsActives').doc(documentId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Une erreur est survenue'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Aucune donnée trouvée'),
            );
          }

          final DocumentSnapshot document = snapshot.data!;
          final String nom = document['nom'];
          final String prenom = document['prenom'] ?? '';
          final String apoge = document['apoge'].toString(); // Convertir en chaîne de caractères
          final String filiere = document['filiere'];
          final String email = document['email'];
           final String sexe = document['sexe']; // Ajouter la récupération de l'attribut sexe

          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                
               Center(
                  child: sexe == 'femelle'
                      ? Image.asset("images/student_girl.png", height: 200)
                      : Image.asset("images/student_boy.png", height: 200),
                ),
                
                 SizedBox(
                  height: 10,
                ),
                buildInfoContainer('Nom', nom),
                buildInfoContainer('Prénom', prenom),
                buildInfoContainer('Apogée', apoge),
                buildInfoContainer('Filière', filiere),
                buildInfoContainer('Email', email),
              ],
            ),
          );
        },
      ),
    );
  }
}
