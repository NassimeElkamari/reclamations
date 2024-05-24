// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AjouterReclamation extends StatefulWidget {
  const AjouterReclamation({super.key});

  @override
  State<AjouterReclamation> createState() => _AjouterReclamationState();
}

class _AjouterReclamationState extends State<AjouterReclamation> {
  String _selectedChoice = 'Vérification de note';
  String? _selectedProfessor;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _apogeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<DropdownMenuItem<String>> _professorItems = [];

  @override
  void initState() {
    super.initState();
    _loadProfessors();
  }

  Future<void> _loadProfessors() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('enseignants').get();
      List<DropdownMenuItem<String>> items = querySnapshot.docs.map((doc) {
        return DropdownMenuItem<String>(
          value: doc.id,
          child: Text(doc['nom']),
        );
      }).toList();
      setState(() {
        _professorItems = items;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des professeurs')),
      );
    }
  }

  Future<void> _ajouterReclamation() async {
    try {
      await FirebaseFirestore.instance.collection('reclamations').add({
        'nom': _nomController.text,
        'prenom': _prenomController.text,
        'apoge': _apogeController.text,
        'sujet': _selectedChoice,
        'description': _descriptionController.text,
        'professeurId': _selectedProfessor,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Réclamation ajoutée avec succès')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigatorBarEtudiant()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ajout de la réclamation')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 51, 128),
        leading: IconButton(
          //button pour retour a la page principale
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigatorBarEtudiant(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Center(
          child: Text(
            "Ajouter votre réclamation",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Button ajouter
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                //color: Color.fromARGB(255, 28, 51, 128),
                width: 120,
                height: 60,
                margin: EdgeInsets.only(top: 20,left: 220),
                child: ElevatedButton(
                  onPressed: _ajouterReclamation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromARGB(255, 28, 51, 128), // Background color
                  ),
                  child: Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            //column pour les elements de la reclamation ajouter par etudiant

            ///pour entrer le nom
            buildTextFormField(
                "Entrer le Nom", _nomController, "Nom", 'Entrer votre Nom'),

            ///pour entrer le prenom
            buildTextFormField("Entrer le Prenom", _prenomController, "Prenom",
                'Entrer votre Prenom'),

            ///pour entrer l'apoge
            buildTextFormField("Entrer Apoge", _apogeController, "Apoge",
                'Entrer votre Apoge'),

            //pour choisir le sujet
            buildDropdownField(
              'Choisissez le sujet de la réclamation:',
              _selectedChoice,
              ['Vérification de note', 'Consultation de copie'],
              (String? newValue) {
                setState(() {
                  _selectedChoice = newValue!;
                });
              },
            ),

            //pour choisir le professeur
            buildDropdownField(
              'Choisissez le professeur:',
              _selectedProfessor,
              _professorItems,
              (String? newValue) {
                setState(() {
                  _selectedProfessor = newValue;
                });
              },
            ),

            //entrer la description de la reclamation
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _descriptionController,
                minLines: 2,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrer la description';
                  }
                  return null;
                },
                decoration: inputDecoration(
                  'Description',
                  'Entrer la description de la réclamation',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label, String hintText) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color.fromARGB(66, 53, 34, 0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Color.fromARGB(255, 4, 19, 105), // Couleur du bord par défaut
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Color.fromARGB(255, 4, 19, 105), // Couleur du bord activé
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildTextFormField(String validatorMessage,
      TextEditingController controller, String label, String hintText) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
        decoration: inputDecoration(label, hintText),
      ),
    );
  }

  Widget buildDropdownField(
    String label,
    String? currentValue,
    List<dynamic> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 9, 61, 156),
            ),
          ),
          DropdownButtonFormField<String>(
            value: currentValue,
            onChanged: onChanged,
            items: items is List<DropdownMenuItem<String>>
                ? items
                : items.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 9, 61, 156), // Changer la couleur ici
                        ),
                      ),
                    );
                  }).toList(),
            decoration: InputDecoration(
              hintText: 'Sélectionnez une option',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
