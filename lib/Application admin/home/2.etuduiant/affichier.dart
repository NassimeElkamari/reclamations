// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AffichierEtud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des étudiants'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('etudiants').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur de chargement des données'),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Aucun étudiant trouvé'),
            );
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFBBDEFB), // Light Blue
                  Color(0xFF90CAF9), // Blue
                ],
              ),
            ),
            child: ListView(
              children: snapshot.data!.docs.map((etudiant) {
                String appoge = etudiant['appoge'];
                String nom = etudiant['nom'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      title: Text(
                        appoge,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        nom,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Modifier '),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Nouveau numéro d\'appoge',
                                      ),
                                      onChanged: (value) {
                                        appoge = value;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Nouveau nom',
                                      ),
                                      onChanged: (value) {
                                        nom = value;
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Mettre à jour les informations dans la base de données
                                      FirebaseFirestore.instance
                                          .collection('etudiants')
                                          .doc(etudiant.id)
                                          .update({
                                        'appoge': appoge,
                                        'nom': nom,
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Enregistrer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
