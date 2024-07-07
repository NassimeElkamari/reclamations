// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/gestion%20enseignant/liste_enseignants.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/navigatorBarAdmi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AjouterEnseignant extends StatefulWidget {
  const AjouterEnseignant({Key? key}) : super(key: key);

  @override
  State<AjouterEnseignant> createState() => _AjouterEnseignantState();
}

class _AjouterEnseignantState extends State<AjouterEnseignant> {
  String? _selectedFiliere; // Variable pour stocker la filière sélectionnée
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final profileController = TextEditingController();

  List<String> _filieres = [
    'Sciences Mathématiques Appliquées (SMA)',
    'Sciences Mathématiques Informatiques (SMI)',
    'Sciences de la Matière Physique (SMP)',
    'Sciences de la Matière Chimie (SMC)',
    'Sciences de la Vie (SVI)',
    "Sciences de la Terre et de l'Univers (STU)",
  ];

  void ajouterEnseignant() {
    String nom = nomController.text;
    String prenom = prenomController.text;
    String email = emailController.text;
    String? profile = profileController.text;

    if (nom.isEmpty ||
        prenom.isEmpty ||
        email.isEmpty ||
        _selectedFiliere == null) {
      // Gérer les champs vides
      return;
    }

    // Ajouter l'enseignant à la base de données
    FirebaseFirestore.instance.collection('enseignants').add({
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'filiere': _selectedFiliere,
      'profile': profile, // Ajout du champ 'profil' avec la valeur de l'URL
    }).then((value) {
      // Enseignant ajouté avec succès
      // Réinitialiser les champs
      nomController.clear();
      prenomController.clear();
      emailController.clear();
      profileController.clear();
      setState(() {
        _selectedFiliere = null;
      });
    }).catchError((error) {
      // Erreur lors de l'ajout de l'enseignant à la base de données
      print("Erreur lors de l'ajout de l'enseignant: $error");
    });
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

        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(3),
          ),
        ),
        title: Center(
          child: Text(
            "Ajouter un enseignant ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor:Color.fromARGB(255, 55, 105, 172), // Couleur de fond de l'AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //column pour les elements de l etudiant ajouter par admin
            SizedBox(
              height: 30,
            ),

            ////pour entrer le nom
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                controller: nomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Nom';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nom',
                   labelStyle: TextStyle(
                    color: Color.fromARGB(255, 55, 105, 172),
                  ),
                  hintText: 'Entrer votre Nom',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 2, 19, 56),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 5, 28, 131),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //pour entrer le prenom
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                controller: prenomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Prenom';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Prenom',
                   labelStyle: TextStyle(
                    color: Color.fromARGB(255, 55, 105, 172),
                  ),
                  hintText: 'Entrer votre Prenom',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 2, 19, 56),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 5, 28, 131),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //pour entrer email enseignant
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 55, 105, 172),
                  ),
                  hintText: 'Entrer votre Email',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 2, 19, 56),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 5, 28, 131),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //pour choisir la filliere
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choisissez la filliere:',
                    style: TextStyle(
                        fontSize: 17, color:Color.fromARGB(255, 55, 105, 172),),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedFiliere,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFiliere = newValue;
                      });
                    },
                    items: _filieres.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 55, 105, 172),),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Sélectionnez une filliere',
                       hintStyle: TextStyle(
                    color: Color.fromARGB(255, 169, 170, 172),
                  ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            ////pour entrer url du profile
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                controller: profileController,
                decoration: InputDecoration(
                  labelText: 'Profil', 
                   labelStyle: TextStyle(
                    color: Color.fromARGB(255, 55, 105, 172),
                  ),// Modifier le libellé du champ
                  hintText:
                      'Entrer le profil de l\'enseignant', // Modifier le texte d'aide
                  hintStyle: TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 13, 39, 95),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(31, 12, 23, 71),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            Container(
              height: 40,
              margin: EdgeInsets.all(30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 55, 105, 172),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: ajouterEnseignant,
                child: Center(
                  child: Text(
                    'Ajouter Enseignant',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}