// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsReclamationPage extends StatefulWidget {
  final Map<String, dynamic> reclamationDetails;

  const DetailsReclamationPage({Key? key, required this.reclamationDetails, String? reclamationId})
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
    _descriptionController.text = widget.reclamationDetails['description'] ?? '';
  }

  Future<void> _updateReclamation() async {
    // Get the document ID of the reclamation to update
    String? reclamationId = widget.reclamationDetails['Document ID'];

    // Get the new response from the text field
    String reponse = _reponseController.text;

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
          .update({'reponse': reponse,'status': true});

      // Update the local response field
      setState(() {
        widget.reclamationDetails['reponse'] = reponse;
      });

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
                onPressed: _updateReclamation,
                child: Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
