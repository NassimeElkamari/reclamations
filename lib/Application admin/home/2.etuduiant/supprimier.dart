import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuppEtudiant extends StatefulWidget {
  const SuppEtudiant({Key? key}) : super(key: key);

  @override
  State<SuppEtudiant> createState() => _SuppEtudiantState();
}

class _SuppEtudiantState extends State<SuppEtudiant> {
  TextEditingController appogeController = TextEditingController();
  String errorMessage = '';

  Future<void> supprimerEtudiant() async {
    String appoge = appogeController.text;

    if (appoge.isNotEmpty) {
      // Rechercher l'étudiant dans la collection "etudiants" de Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('etudiants')
          .where('appoge', isEqualTo: appoge)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Afficher un message d'erreur si aucun document correspondant n'est trouvé
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text('Aucun étudiant trouvé avec cet appoge.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Supprimer l'étudiant de la collection "etudiants" de Firestore
        await FirebaseFirestore.instance
            .collection('etudiants')
            .doc(querySnapshot.docs.first.id)
            .delete();

        // Afficher un message de succès
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Étudiant supprimé avec succès'),
              content: Text(
                  'L\'étudiant avec l\'appoge $appoge a été supprimé de la base de données.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }

      // Effacer le champ de saisie après la suppression
      appogeController.clear();
      setState(() {
        errorMessage = '';
      });
    } else {
      setState(() {
        errorMessage = 'Veuillez entrer le numéro d\'appoge';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supprimer un étudiant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: appogeController,
              decoration: InputDecoration(
                labelText: 'Numéro d\'appoge de l\'étudiant',
                errorText: errorMessage.isNotEmpty ? errorMessage : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: supprimerEtudiant,
              child: Text('Supprimer l\'étudiant'),
            ),
          ],
        ),
      ),
    );
  }
}
