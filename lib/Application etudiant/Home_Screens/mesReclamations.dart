// ignore_for_file: prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MesReclamations extends StatefulWidget {
  const MesReclamations({super.key});

  @override
  State<MesReclamations> createState() => _MesReclamationsState();
}

class _MesReclamationsState extends State<MesReclamations> {
  String? apoge;

  @override
  void initState() {
    super.initState();
    _loadApoge();
  }

  Future<void> _loadApoge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apoge = prefs.getString('apogeConnecte');
    if (apoge != null) {
      setState(() {
        this.apoge = apoge;
      });
    } else {
      print('No apoge found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
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
        title: Text(
          "Mes réclamations",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reclamations')
            .where('apogeEtudiant', isEqualTo: apoge)
            .orderBy('date',
                descending: true) // Sort by date in descending order
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucune réclamation trouvée.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 238, 116, 17),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  // Display the subject of the complaint and the professor
                  title: Text(
                    data['sujet'],
                    style: TextStyle(
                      fontSize: 21,
                      color: Color.fromARGB(255, 55, 105, 172),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 10,
                            color: Color.fromARGB(255, 238, 116, 17),
                          ),
                          Text(
                            ' Professeur:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 238, 116, 17),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${data['nomEnseignant']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 28, 51, 128),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: data['status'] == true ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsPage(reclamationData: data),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> reclamationData;

  DetailsPage({required this.reclamationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
        title: Text(
          'Détails de la réclamation',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          //button pour retour a la page principale
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MesReclamations(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Sujet :",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 10, 72, 153),
                      fontWeight: FontWeight.bold),
                ),
              ),
              AfficherDetailsReclamation(reclamationData['sujet'], 17, 40),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Nom etudiant :",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 10, 72, 153),
                        fontWeight: FontWeight.bold)),
              ),
              AfficherDetailsReclamation(
                  reclamationData['nomEtudiant'], 17, 40),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Nom de l'enseignant:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 10, 72, 153),
                      fontWeight: FontWeight.bold),
                ),
              ),
              AfficherDetailsReclamation(
                  reclamationData['nomEnseignant'], 17, 40),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Description:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 10, 72, 153),
                      fontWeight: FontWeight.bold),
                ),
              ),
              AfficherDetailsReclamation(
                  reclamationData['description'], 15, 160),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                 padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Date :",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 10, 72, 153),
                      fontWeight: FontWeight.bold),
                ),
              ),
              AfficherDetailsReclamation(
                  (reclamationData['date'] as Timestamp).toDate().toString(),
                  15,
                  30),
            ],
          ),
        ],
      ),
    );
  }
}

Widget AfficherDetailsReclamation(String valeur, double taille, double toul) {
  return Padding(
    padding: const EdgeInsets.only(left: 14, bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 5),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 12),
            height: toul,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 238, 116, 17),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                ' $valeur ',
                style: TextStyle(
                  fontSize: taille,
                  color: Color.fromARGB(255, 55, 105, 172),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
