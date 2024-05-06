// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/ajouter.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/supprimier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Liste_des_etudiants extends StatefulWidget {
  const Liste_des_etudiants({super.key});

  @override
  State<Liste_des_etudiants> createState() => _Liste_des_etudiantsState();
}

class _Liste_des_etudiantsState extends State<Liste_des_etudiants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "          Etudiants",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 50, 93, 150),
        actions: [
          IconButton(
            icon: Icon(Icons.person_remove),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuppEtudiant()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjouterEtudiant()),
              );
            },
          ),
        ], // Couleur de la barre d'applications
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
                  Color.fromARGB(255, 10, 30, 97),
                  Color.fromARGB(255, 101, 162, 243),
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
