// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:application_gestion_des_reclamations_pfe/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AjouterReclamation extends StatefulWidget {
  const AjouterReclamation({super.key});

  @override
  State<AjouterReclamation> createState() => _AjouterReclamationState();
}

class _AjouterReclamationState extends State<AjouterReclamation> {
  String _selectedChoice = 'Vérification de note';
  String? _selectedProfessor;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _apogeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? emailProf;
  List<DropdownMenuItem<String>> _professorItems = [];
  Map<String, String> professorEmails = {}; // Map to store professor emails

  @override
  void initState() {
    super.initState();
    _loadProfessors();
  }
  Future<void> _loadProfessors() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('enseignants').get();
      List<DropdownMenuItem<String>> items = querySnapshot.docs.map((doc) {
        String nom = doc['nom'];
        String prenom = doc['prenom'];
        String email = doc['email'];

        String fullName = '$nom $prenom'; // Concaténer le nom et le prénom
        professorEmails[fullName] = email; // Store the email in the map

        return DropdownMenuItem<String>(
          value: fullName, // Utilisez le nom complet comme valeur
          child: Text(fullName),
        );
      }).toList();
      setState(() {
        _professorItems = items;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des professeurs')),
      );
    }
  }

  Future<void> _ajouterReclamation() async {
  if (_selectedProfessor != null) {
    emailProf = professorEmails[_selectedProfessor]; // Get the email of the selected professor
  }

  try {
    // Generate a document reference with a specific ID
    DocumentReference docRef = FirebaseFirestore.instance.collection('reclamations').doc();

    await docRef.set({
      'idReclamation': docRef.id, // Set the document ID as a field in the document
      'nomEtudiant': '${_nomController.text} ${_prenomController.text}',
      'apogeEtudiant': _apogeController.text,
      'sujet': _selectedChoice,
      'description': _descriptionController.text,
      'nomEnseignant': _selectedProfessor,
      'date': FieldValue.serverTimestamp(),
      'email': emailProf,
      'status': false,
      'reponse': " ",
    });

   // await _sendNotificationToProfessor(emailProf);
    await _sendNotificationToProfessor(emailProf);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Réclamation ajoutée avec succès')),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigatorBarEtudiant()),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur lors de l\'ajout de la réclamation')),
    );
  }
}

// Fonction pour récupérer le dernier ID de réclamation depuis Firestore
Future<int> _dernierIdReclamation() async {
  // Récupérer la référence à la collection de réclamations triée par ID descendant
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('reclamations')
      .orderBy('idReclamation', descending: true)
      .limit(1)
      .get();

  // Vérifier s'il y a des documents
  if (querySnapshot.docs.isNotEmpty) {
    // Récupérer le dernier document (avec l'ID le plus élevé)
    var doc = querySnapshot.docs.first;

    // Récupérer et retourner l'ID de réclamation
    return doc['idReclamation'];
  } else {
    // Si la collection est vide, retourner 0 comme premier ID
    return 0;
  }
}

Future<void> _sendNotificationToProfessor(String? emailProf) async {
    if (emailProf == null) return;

    try {
      // Get the FCM token of the professor
      final querySnapshot = await FirebaseFirestore.instance
          .collection('enseignants')
          .where('email', isEqualTo: emailProf)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String fcmToken = querySnapshot.docs.first['fcmToken'];

        AccessTokenFirebase accessTokenFirebase = AccessTokenFirebase();
        String token = await accessTokenFirebase.getAccessToken();
        print('TTTT*******************************$token');

        // Construct the notification message
        String studentName = '${_nomController.text} ${_prenomController.text}';
        String notificationBody =
            'Vous avez une nouvelle réclamation de la part de $studentName';

        // Send the notification using FCM
        await http.post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/final-pfe-project/messages:send'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "message": {
              "token": fcmToken,
              "notification": {"body": notificationBody, "title": "FsTetouan"}
            }
          }),
        );
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
        leading: IconButton(
          //button pour retour a la page principale
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigatorBarEtudiant(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Center(
          child: Text(
            "Ajouter votre réclamation",
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),

            //column pour les elements de la reclamation ajouter par etudiant

            ///pour entrer le nom
            buildTextFormField(
                "Entrer le Nom", _nomController, "Nom", 'Entrer votre Nom'),

            ///pour entrer le prenom
            buildTextFormField("Entrer le Prenom", _prenomController, "Prenom",
                'Entrer votre Prenom'),

            ///pour entrer l'apoge
            buildTextFormField("Entrer Apoge", _apogeController, "Apoge",
                'Entrer votre Apoge'),

            //pour choisir le sujet
            buildDropdownField(
              'Choisissez le sujet de la réclamation:',
              _selectedChoice,
              ['Vérification de note', 'Consultation de copie'],
              (String? newValue) {
                setState(() {
                  _selectedChoice = newValue!;
                });
              },
            ),

            //pour choisir le professeur
            buildDropdownField(
              'Choisissez le professeur:',
              _selectedProfessor,
              _professorItems,
              (String? newValue) {
                setState(() {
                  _selectedProfessor = newValue;
                });
              },
            ),

            //entrer la description de la reclamation
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _descriptionController,
                minLines: 2,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrer la description';
                  }
                  return null;
                },
                decoration: inputDecoration(
                  'Description',
                  'Entrer la description de la réclamation',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                //color: Color.fromARGB(255, 28, 51, 128),
                width: 120,
                height: 60,
                margin: EdgeInsets.only(top: 20, left: 220),
                child: ElevatedButton(
                  onPressed: _ajouterReclamation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 238, 116, 17),   // Background color
                  ),
                  child: Text(
                    "Ajouter",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label, String hintText) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color.fromARGB(255, 55, 105, 172)),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color.fromARGB(66, 53, 34, 0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color:
              Color.fromARGB(255, 238, 116, 17), // Couleur du bord par défaut
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Color.fromARGB(255, 238, 116, 17), // Couleur du bord activé
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildTextFormField(String validatorMessage,
      TextEditingController controller, String label, String hintText) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
        decoration: inputDecoration(label, hintText),
      ),
    );
  }

  Widget buildDropdownField(
    String label,
    String? currentValue,
    List<dynamic> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 55, 105, 172),
            ),
          ),
          DropdownButtonFormField<String>(
            value: currentValue,
            onChanged: onChanged,
            items: items is List<DropdownMenuItem<String>>
                ? items
                : items.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Color.fromARGB(255, 9, 61, 156), // Changer la couleur ici
                        ),
                      ),
                    );
                  }).toList(),
            decoration: InputDecoration(
              hintText: 'Sélectionnez une option',
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 201, 202, 202),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(
                      255, 238, 116, 17), // Couleur du bord activé
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
