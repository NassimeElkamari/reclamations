// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
    String apoge = emailController.text;

    if (nom.isEmpty || prenom.isEmpty || apoge.isEmpty || _selectedFiliere == null) {
      // Gérer les champs vides
      return;
    }

    // Ajouter l'enseignant à la base de données
    FirebaseFirestore.instance.collection('enseignants').add({
      'nom': nom,
      'prenom': prenom,
      'apoge': apoge,
      'filiere': _selectedFiliere,
    }).then((value) {
      // Enseignant ajouté avec succès
      // Réinitialiser les champs
      nomController.clear();
      prenomController.clear();
      emailController.clear();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 10, 30, 97),
                  Color.fromARGB(255, 101, 162, 243),
                ]),
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 10, 30, 97),
                  Color.fromARGB(255, 101, 162, 243),
                ]),
              ),
              child: Row(
                children: [
                  IconButton(
                    //button pour retour a la page principale
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigatorBarAdmin(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: Text(
                      "Ajouter votre réclamation",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

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
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nom',
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
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Prenom',
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
                  labelText: 'Apoge',
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
                        fontSize: 17, color: Color.fromARGB(255, 9, 61, 156)),
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
                              color: Color.fromARGB(255, 9, 61, 156)),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Sélectionnez une filliere',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),

            //button ajouter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Annuler"),
                  ),
                ),
                Container(
                  width: 120,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      ajouterEnseignant();
                    },
                    child: Text("Ajouter"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
