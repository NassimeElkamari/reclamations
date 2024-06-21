// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_super_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsReclamationPage extends StatefulWidget {
  final Map<String, dynamic> reclamationDetails;

  const DetailsReclamationPage({Key? key, required this.reclamationDetails})
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
    _descriptionController.text = widget.reclamationDetails['description'];
  }

  Future<void> updatereponse() async {
    final response = _reponseController.text.trim(); // trim whitespace
    if (response.isNotEmpty) {
      try {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection('reclamations')
            .doc('${widget.reclamationDetails['id']}');

        DocumentSnapshot doc = await docRef.get();
        if (doc.exists) {
          await docRef.update({
            'reponse': response,
            'status': 'resolved', // Assuming 'resolved' is the new status
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Réponse envoyée avec succès!')),
          );

          // Clear the response text field
          _reponseController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Document non trouvé')),
          );
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Erreur lors de l\'envoi de la réponse: ${e.message}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer une réponse')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la réclamation'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sujet: ${widget.reclamationDetails['sujet']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Nom de l\'étudiant: ${widget.reclamationDetails['nomEtudiant']}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Réponse:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _reponseController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Écrivez votre réponse ici...',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: updatereponse,
                child: Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
