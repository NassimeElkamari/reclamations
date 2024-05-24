// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileEtudiant extends StatefulWidget {
  const ProfileEtudiant({super.key});

  @override
  State<ProfileEtudiant> createState() => _ProfileEtudiantState();
}
 
class _ProfileEtudiantState extends State<ProfileEtudiant> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _filieres = [
    'Sciences Mathématiques Appliquées (SMA)',
    'Sciences Mathématiques Informatiques (SMI)',
    'Sciences de la Matière Physique (SMP)',
    'Sciences de la Matière Chimie (SMC)',
    'Sciences de la Vie (SVI)',
    "Sciences de la Terre et de l'Univers (STU)",
  ];

  String? _selectedFiliere;
  String? _imageURL;

  String nom = '';
  String prenom = '';
  String apoge = '';
  String filiere = '';
  String sexe = '';
  String? email = UserInfo.emailconnecte;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _apogeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 51, 128),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: Row(
          children: [
            SizedBox(width: 70),
            Text(
              "Mon profil",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore
            .collection('etudiantsActives')
            .where('email', isEqualTo: email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data found for the given email."));
          }

          var data = snapshot.data!.docs.first.data();
          nom = data['nom'] ?? '';
          prenom = data['prenom'] ?? '';
          apoge = (data['apoge'] ?? '').toString();
          filiere = data['filiere'] ?? '';
          sexe = data['sexe'] ?? '';

          // Update controllers
          _nomController.text = nom;
          _prenomController.text = prenom;
          _apogeController.text = apoge;
          _selectedFiliere = filiere;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                //**********photo de profile ***********/
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: SizedBox(
                      width: 200,
                      height: 160,
                      child: Image.asset(
                        'images/profile_student.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              //*********modfifier photo de profile ********/
              Center(
                child: InkWell(
                  onTap: () async {
                    // Code to pick an image from gallery (commented out for now)
                    /*
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      setState(() {
                        _imageURL = pickedFile.path;
                      });
                    }
                    */
                  },
                  child: Text(
                    "Editer photo de profile",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              AfficherInformationEtudiant('Nom', nom, 20, 40),
              AfficherInformationEtudiant('Prenom', prenom, 20, 40),
              AfficherInformationEtudiant('Apoge', apoge, 20, 40),
              AfficherInformationEtudiant('Filiere', filiere, 18, 65),
              AfficherInformationEtudiant('Sexe', sexe, 20, 40),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      // Action à exécuter lorsque le bouton est pressé
                      _showEditModal(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 4, 19, 105),
                    ),
                    child: Text("Modifier"),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Padding AfficherInformationEtudiant(
      String label, String valeur, double taille, double toul) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 5),
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 19, 105),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 12),
              height: toul,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 4, 19, 105),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  ' $valeur ',
                  style: TextStyle(
                    fontSize: taille,
                    color: Color.fromARGB(255, 4, 19, 105),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditModal(BuildContext context) {
    String? localSelectedFiliere = _selectedFiliere;
    String localSexe = sexe;

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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _nomController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _prenomController,
                    decoration: InputDecoration(
                      labelText: 'Prénom',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _apogeController,
                    decoration: InputDecoration(
                      labelText: 'Apoge',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Filiere',
                      border: OutlineInputBorder(),
                    ),
                    value: localSelectedFiliere,
                    onChanged: (newValue) {
                      setState(() {
                        localSelectedFiliere = newValue;
                      });
                    },
                    items: _filieres.map((filiere) {
                      return DropdownMenuItem<String>(
                        value: filiere,
                        child: Text(
                          filiere,
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Sexe',
                      border: OutlineInputBorder(),
                    ),
                    value: localSexe.isEmpty ? null : localSexe,
                    onChanged: (newValue) {
                      setState(() {
                        localSexe = newValue!;
                      });
                    },
                    items: <String>['male', 'femelle']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filiere = localSelectedFiliere ?? filiere;
                        sexe = localSexe;
                      });
                      _updateEtudiantData();
                      Navigator.pop(context);
                    },
                    child: Text('Sauvegarder'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateEtudiantData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('etudiantsActives')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;

        await _firestore.collection('etudiantsActives').doc(docId).update({
          'nom': _nomController.text,
          'prenom': _prenomController.text,
          'apoge': int.parse(_apogeController.text),
          'filiere': filiere,
          'sexe': sexe,
        });
        print("Data updated successfully.");
      } else {
        print("No document found for the given email.");
      }
    } catch (e) {
      print("Error updating data: $e");
    }
  }
}

