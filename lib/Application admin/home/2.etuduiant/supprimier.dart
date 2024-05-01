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
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('etudiants')
          .where('appoge', isEqualTo: appoge)
          .get();

      if (querySnapshot.docs.isEmpty) {
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
        await FirebaseFirestore.instance
            .collection('etudiants')
            .doc(querySnapshot.docs.first.id)
            .delete();

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
        backgroundColor: Color.fromRGBO(89, 139, 231, 1),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(206, 232, 250, 1),
                  Color.fromRGBO(245, 245, 245, 1),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/background_image.jpg', // Chemin de l'image
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: appogeController,
                  decoration: InputDecoration(
                    labelText: 'Numéro d\'appoge de l\'étudiant',
                    errorText: errorMessage.isNotEmpty ? errorMessage : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: supprimerEtudiant,
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Supprimer l\'étudiant'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
