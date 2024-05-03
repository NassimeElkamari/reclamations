
import 'package:flutter/material.dart';

class pastraiter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulation des réclamations non traitées par l'enseignant
    List<String> reclamationsNonTraitees = [
      'Réclamation 5',
      'Réclamation 6',
      'Réclamation 7',
      'Réclamation 8',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Réclamations non traitées'),
      ),
      body: ListView.builder(
        itemCount: reclamationsNonTraitees.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(reclamationsNonTraitees[index]),
            // Vous pouvez ajouter d'autres détails de réclamation si nécessaire
          );
        },
      ),
    );
  }
}
