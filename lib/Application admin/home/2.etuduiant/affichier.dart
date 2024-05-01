import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AffichierEtud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des étudiants'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('etudiants').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur de chargement des données'),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Aucun étudiant trouvé'),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              headingTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              dataTextStyle: TextStyle(color: Colors.black),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              columns: [
                DataColumn(
                  label: Text('Appoge'),
                ),
                // Ajoutez d'autres colonnes si nécessaire
              ],
              rows: snapshot.data!.docs.map((etudiant) {
                return DataRow(cells: [
                  DataCell(Text(etudiant['appoge'])),
                  // Ajoutez d'autres cellules pour d'autres champs d'information si nécessaire
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
