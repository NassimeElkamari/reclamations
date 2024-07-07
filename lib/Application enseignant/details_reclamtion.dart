// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:application_gestion_des_reclamations_pfe/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsReclamationPage extends StatefulWidget {
  final Map<String, dynamic> reclamationDetails;

  const DetailsReclamationPage(
      {Key? key, required this.reclamationDetails, String? reclamationId})
      : super(key: key);

  @override
  State<DetailsReclamationPage> createState() => _DetailsReclamationPageState();
}

class _DetailsReclamationPageState extends State<DetailsReclamationPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _reponseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the description controller with the description from reclamation details
    _descriptionController.text =
        widget.reclamationDetails['description'] ?? '';
  }

  Future<void> _sendNotificationToStudent(
      String? apogeEtudiant, String message) async {
    try {
      // Get the FCM token of the student
      final querySnapshot = await FirebaseFirestore.instance
          .collection('etudiantsActives')
          .where('apoge', isEqualTo: apogeEtudiant)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Log the document data for debugging
        print('Document data: ${querySnapshot.docs.first.data()}');

        if (querySnapshot.docs.first.data().containsKey('fcmToken')) {
          String fcmToken = querySnapshot.docs.first['fcmToken'];
          print('fcmToken: $fcmToken');

          AccessTokenFirebase accessTokenFirebase = AccessTokenFirebase();
          String token = await accessTokenFirebase.getAccessToken();

          // Send the notification using FCM
          final response = await http.post(
            Uri.parse(
                'https://fcm.googleapis.com/v1/projects/final-pfe-project/messages:send'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              "message": {
                "token": fcmToken,
                "notification": {
                  "body": message,
                  "title": "Fs Tetouan"
                }
              }
            }),
          );

          if (response.statusCode == 200) {
            print('Notification sent successfully');
          } else {
            print(
                'Failed to send notification: ${response.statusCode} ${response.body}');
          }
        } else {
          print('Error: fcmToken field does not exist in the document');
        }
      } else {
        print('Error: No document found with apoge $apogeEtudiant');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<void> _updateReclamation() async {
    // Get the document ID of the reclamation to update
    String? reclamationId = widget.reclamationDetails['Document ID'];

    // Get the new response from the text field
    String reponse = _reponseController.text;
    print(reponse);

    // Check if reclamationId is not null
    if (reclamationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ID de réclamation manquant.')),
      );
      print('Erreur : ID de réclamation manquant.');
      return;
    }

    // Update the reclamation in Firestore
    try {
      await FirebaseFirestore.instance
          .collection('reclamations')
          .doc(reclamationId)
          .update({'reponse': reponse, 'status': true});

      // Update the local response field
      setState(() {
        widget.reclamationDetails['reponse'] = reponse;
      });

      print(widget.reclamationDetails);

      // Notify the student about the response
      String apogeEtudiant = widget.reclamationDetails['apogeEtudiant'];
      String enseignant = widget.reclamationDetails['nomEnseignant'];
      String message = 'Mr. $enseignant a répondu à votre réclamation.';
      await _sendNotificationToStudent(apogeEtudiant, message);

      // Show a success message or navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Réponse envoyée avec succès')),
      );

      // Optionally, navigate back after updating
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'envoi de la réponse : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 55, 105, 172),
        ),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Détails de la réclamation',
            style: TextStyle(
                color: Color.fromARGB(255, 55, 105, 172), fontSize: 23),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Sujet: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 105, 172),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 238, 116, 17),
                        )),
                    child: Center(
                      child: Text(
                        '${widget.reclamationDetails['sujet']}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Nom de l\'étudiant: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 105, 172),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 238, 116, 17),
                        )),
                    child: Center(
                      child: Text(
                        '${widget.reclamationDetails['nomEtudiant']}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Description: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 105, 172),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints
                            .maxWidth, // Utilise la largeur maximale disponible
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 238, 116, 17),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.reclamationDetails['description']}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'Réponse:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 55, 105, 172),
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _reponseController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      // Couleur et épaisseur du bord
                      color:
                          Color.fromARGB(255, 55, 105, 172), // Couleur du bord
                      width: 2, // Épaisseur du bord
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 238, 116, 17), // Couleur du bord normal
                      width: 2, // Épaisseur du bord normal
                    ),
                  ),
                  hintText: 'Écrivez votre réponse ici...',
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: 200, // Définir la largeur souhaitée
                child: ElevatedButton(
                  onPressed: () {
                    _updateReclamation();
                    print(
                        '************************************************************************************************************************************************************************************************************${widget.reclamationDetails['Document ID']}');
                  },
                  child: Text(
                    'Envoyer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Color.fromARGB(255, 238, 116, 17), // Couleur de fond
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Bordure arrondie
                      side: BorderSide(
                        color: Color.fromARGB(
                            255, 238, 168, 112), // Couleur de la bordure
                        width: 2, // Épaisseur de la bordure
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15), // Padding interne
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
