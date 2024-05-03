// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class Traiter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulation des réclamations traitées par l'enseignant
    List<String> reclamationsTraitees = [
      'Réclamation 1',
      'Réclamation 2',
      'Réclamation 3',
      'Réclamation 4',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Réclamations traitées'),
      ),
      body: ListView.builder(
        itemCount: reclamationsTraitees.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(reclamationsTraitees[index]),
            // Vous pouvez ajouter d'autres détails de réclamation si nécessaire
          );
        },
      ),
    );
  }
}
