// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class reclamation_Traitee extends StatefulWidget {
  final Map<String, dynamic> reclamationDetails;

  const reclamation_Traitee(
      {Key? key, required this.reclamationDetails, String? reclamationId})
      : super(key: key);

  @override
  State<reclamation_Traitee> createState() => _reclamation_TraiteeState();
}

class _reclamation_TraiteeState extends State<reclamation_Traitee> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _reponseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the description controller with the description from reclamation details
    _descriptionController.text =
        widget.reclamationDetails['description'] ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 55, 105, 172),
        ),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Détails de la réclamation',
            style: TextStyle(
                color: Color.fromARGB(255, 55, 105, 172), fontSize: 23),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Sujet: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 105, 172),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 238, 116, 17),
                        )),
                    child: Center(
                      child: Text(
                        '${widget.reclamationDetails['sujet']}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Nom de l\'étudiant: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 105, 172),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 238, 116, 17),
                        )),
                    child: Center(
                      child: Text(
                        '${widget.reclamationDetails['nomEtudiant']}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Description: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 105, 172),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints
                            .maxWidth, // Utilise la largeur maximale disponible
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 238, 116, 17),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.reclamationDetails['description']}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
                 SizedBox(height: 20.0),
                Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Réponse: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 105, 172),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints
                            .maxWidth, // Utilise la largeur maximale disponible
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 238, 116, 17),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.reclamationDetails['reponse']}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              
              
              
           
              
            ],
          ),
        ),
      ),
    );
  }
}
