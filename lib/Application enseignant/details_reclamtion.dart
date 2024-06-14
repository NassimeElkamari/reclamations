import 'package:flutter/material.dart';

class DetailsReclamationPage extends StatefulWidget {
  final Map<String, dynamic> reclamationDetails;

  const DetailsReclamationPage({Key? key, required this.reclamationDetails}) : super(key: key);

  @override
  State<DetailsReclamationPage> createState() => _DetailsReclamationPageState();
}

class _DetailsReclamationPageState extends State<DetailsReclamationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la réclamation'),
      ),
      body: Container(
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
              style: TextStyle(fontSize: 16.0),
            ),
            // Ajoutez d'autres détails de réclamation ici
          ],
        ),
      ),
    );
  }
}
