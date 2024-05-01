import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AjouterEtudiant extends StatefulWidget {
  const AjouterEtudiant({Key? key}) : super(key: key);

  @override
  _AjouterEtudiantState createState() => _AjouterEtudiantState();
}

class _AjouterEtudiantState extends State<AjouterEtudiant> {
  TextEditingController appogeController = TextEditingController();
  String errorMessage = '';

  Future<void> ajouterEtudiant() async {
    String appoge = appogeController.text;

    if (appoge.isNotEmpty) {
      // Ajouter l'étudiant dans la collection "etudiants" de Firestore
      await FirebaseFirestore.instance.collection('etudiants').add({
        'appoge': appoge,
        // Ajoutez d'autres champs d'information si nécessaire
      });

      // Afficher un message de succès
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Étudiant ajouté avec succès'),
            content: Text(
                'L\'étudiant avec l\'appoge $appoge a été ajouté à la base de données.'),
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

      // Effacer le champ de saisie après l'ajout
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
        title: Text('Ajouter un étudiant'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/student_icon.png', // Chemin de l'image
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: appogeController,
              decoration: InputDecoration(
                labelText: 'Numéro d\'appoge de l\'étudiant',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: errorMessage.isNotEmpty ? errorMessage : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ajouterEtudiant,
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Ajouter l\'étudiant'),
            ),
          ],
        ),
      ),
    );
  }
}
