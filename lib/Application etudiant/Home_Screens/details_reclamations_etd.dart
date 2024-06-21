import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/mesReclamations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> reclamationData;
  final TextEditingController _sujetController;
  final TextEditingController _nomEtudiantController;
  final TextEditingController _nomEnseignantController;
  final TextEditingController _descriptionController;

  DetailsPage({required this.reclamationData})
      : _sujetController = TextEditingController(text: reclamationData['sujet']),
        _nomEtudiantController = TextEditingController(text: reclamationData['nomEtudiant']),
        _nomEnseignantController = TextEditingController(text: reclamationData['nomEnseignant']),
        _descriptionController = TextEditingController(text: reclamationData['description']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
        title: Text(
          'Détails de la réclamation',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MesReclamations(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildDetailSection("Sujet :", reclamationData['sujet']),
          _buildDetailSection("Nom etudiant :", reclamationData['nomEtudiant']),
          _buildDetailSection("Nom de l'enseignant:", reclamationData['nomEnseignant']),
          _buildDetailSection("Description:", reclamationData['description']),
          _buildDetailSection("Date :", (reclamationData['date'] as Timestamp).toDate().toString()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                _showEditModal(context);
              },
              child: Text("Modifier"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 10, 72, 153),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AfficherDetailsReclamation(value, 17, 40, 200),
      ],
    );
  }

  void _showEditModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modifier les informations',
                    style: TextStyle(
                      color: Color.fromARGB(255, 55, 105, 172),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField('Sujet', _sujetController),
                  SizedBox(height: 20),
                  _buildTextField('Nom etudiant', _nomEtudiantController),
                  SizedBox(height: 20),
                  _buildTextField('Nom de l\'enseignant', _nomEnseignantController),
                  SizedBox(height: 20),
                  _buildTextField('Description', _descriptionController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 84, 132, 196),
                      ),
                    ),
                    onPressed: () {
                      _updateReclamationInfo();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Enregistrer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Color.fromARGB(255, 55, 105, 172),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 238, 116, 17),
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 238, 116, 17),
          ),
        ),
      ),
    );
  }

  void _updateReclamationInfo() {
    FirebaseFirestore.instance
        .collection('reclamations')
        .doc(reclamationData['id'])
        .update({
      'sujet': _sujetController.text,
      'nomEtudiant': _nomEtudiantController.text,
      'nomEnseignant': _nomEnseignantController.text,
      'description': _descriptionController.text,
    }).then((value) {
      print("Reclamation Updated");
    }).catchError((error) {
      print("Failed to update reclamation: $error");
    });
  }
}

Widget AfficherDetailsReclamation(String valeur, double taille, double toul, double l3ard) {
  return Padding(
    padding: const EdgeInsets.only(left: 14, bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 5),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 12),
            height: toul,
            width: l3ard,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 238, 116, 17),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                ' $valeur ',
                style: TextStyle(
                  fontSize: taille,
                  color: Color.fromARGB(255, 55, 105, 172),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
