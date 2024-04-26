import 'package:flutter/material.dart';

class AjouterReclamation extends StatefulWidget {
  const AjouterReclamation({super.key});

  @override
  State<AjouterReclamation> createState() => _AjouterReclamationState();
}

class _AjouterReclamationState extends State<AjouterReclamation> {
  @override
  String _selectedChoice = 'Vérification de note';
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 17, 58, 180),
                Color.fromARGB(255, 249, 248, 255),
              ])),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 17, 58, 180),
                Color.fromARGB(255, 249, 248, 255),
              ])),
              child: Row(
                children: [
                  IconButton(
                      //button pour retour a la page principale
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                      child: Text(
                    "Ajouter votre réclamation",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
                ],
              ),
            ),

            //column pour les elements de la reclamation ajouter par etudiant
            SizedBox(
              height: 30,
            ),

            ////pour entrer le nom
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text(
                    'Nom',
                    style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                  ),
                  hintText: 'Entrer votre Nom',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color:
                          Color.fromARGB(31, 2, 19, 56), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(
                          31, 5, 28, 131), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //pour entrer le prenom
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text(
                    'Prenom',
                    style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                  ),
                  hintText: 'Entrer votre Prenom',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color:
                          Color.fromARGB(31, 2, 19, 56), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(
                          31, 5, 28, 131), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //pour entrer apoge de l'etudiant
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text(
                    'Apoge',
                    style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                  ),
                  hintText: 'Entrer votre Apoge',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color:
                          Color.fromARGB(31, 2, 19, 56), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(
                          31, 5, 28, 131), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //pour choisir le sujet
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choisissez le sujet de la réclamation:',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 9, 61, 156)),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedChoice,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedChoice = newValue!;
                      });
                    },
                    items: <String>[
                      'Vérification de note',
                      'Consultation de copie'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Color.fromARGB(
                                  255, 9, 61, 156)), // Changer la couleur ici
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Sélectionnez une option',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),

            //entrer la descripiton de la reclamation
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: TextFormField(
                minLines: 2,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrer la description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Container(
                    //margin: EdgeInsets.only(top: 1, left: 1, right: 30),
                    child: const Text(
                      'Description',
                      style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                    ),
                  ),
                  hintText: 'Entrer la description de la réclamation',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(66, 0, 8, 53),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color:
                          Color.fromARGB(31, 3, 22, 61), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color:
                          Color.fromARGB(31, 3, 10, 41), // Default border color
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //entrer le professor
           
          ],
        ),
      ),
    );
  }
}
